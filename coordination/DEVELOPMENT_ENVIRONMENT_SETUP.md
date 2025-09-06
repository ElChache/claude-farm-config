# Development Environment Setup

## Prerequisites

- Node.js 18+ (use .nvmrc for version management)
- pnpm (package manager)
- Docker and Docker Compose
- Git CLI
- GitHub CLI (`gh`)

## Quick Start

```bash
# 1. Set Node.js version
nvm use

# 2. Install dependencies
pnpm install

# 3. Set up environment variables
cp .env.example .env
# Edit .env with your specific values

# 4. Start development services
docker-compose up -d

# 5. Run database migrations
pnpm run db:migrate

# 6. Start development server
pnpm dev
```

## Agent Isolation Setup (REQUIRED)

**All development agents MUST use isolated environments per the Agent Isolation Protocol.**

### Step 1: Create Your Agent ID
```bash
AGENT_ID="agent_$(date +%s)_$(openssl rand -hex 2)"
echo "Your Agent ID: $AGENT_ID"
```

### Step 2: Calculate Your Ports
Use this algorithm to get unique ports:
```javascript
function getAgentPorts(agentId) {
  let hash = 0;
  for (let i = 0; i < agentId.length; i++) {
    hash = ((hash << 5) - hash + agentId.charCodeAt(i)) & 0xffffffff;
  }
  const basePort = 5000 + (Math.abs(hash) % 4000);
  return {
    app: basePort,
    db: basePort + 1,
    redis: basePort + 2,
    api: basePort + 3,
    playwright: basePort + 4
  };
}
```

### Step 3: Create Isolated Worktree
```bash
# Create your isolated workspace
git worktree add /tmp/agent_workspaces/$AGENT_ID -b ${AGENT_ID}_work
cd /tmp/agent_workspaces/$AGENT_ID

# Copy and customize docker-compose template
cp docker-compose.template.yml docker-compose.yml
```

### Step 4: Configure Environment Variables
Create your `.env` file:
```bash
# Your calculated ports
APP_PORT=5347       # Replace with your calculated port
DB_PORT=5348        # APP_PORT + 1
REDIS_PORT=5349     # APP_PORT + 2
API_PORT=5350       # APP_PORT + 3
PLAYWRIGHT_PORT=5351 # APP_PORT + 4

# Database
DATABASE_URL=postgresql://postgres:password@localhost:${DB_PORT}/monitors_${AGENT_ID}

# Agent identification
AGENT_ID=${AGENT_ID}

# AI Providers (will be provided by project owner)
CLAUDE_API_KEY=your_claude_api_key_here
OPENAI_API_KEY=your_openai_api_key_here
```

## Docker Compose Template

Since the Lead Developer hasn't provided the template yet, here's a basic template:

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "\${APP_PORT}:5173"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:password@db:5432/monitors_\${AGENT_ID}
      - AGENT_ID=\${AGENT_ID}
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db

  db:
    image: postgres:15
    ports:
      - "\${DB_PORT}:5432"
    environment:
      - POSTGRES_DB=monitors_\${AGENT_ID}
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_HOST_AUTH_METHOD=trust
    volumes:
      - postgres_data_\${AGENT_ID}:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "\${REDIS_PORT}:6379"
    volumes:
      - redis_data_\${AGENT_ID}:/data

volumes:
  postgres_data_\${AGENT_ID}:
  redis_data_\${AGENT_ID}:
```

## Development Workflow

1. **Work in your isolated worktree only**
2. **Test your changes locally**
3. **Commit and push to your branch**
4. **Create PR for Lead Developer review**
5. **Clean up worktree after PR is merged**

## Testing Commands

```bash
# Run all tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run Playwright visual tests
pnpm test:playwright

# Run linting
pnpm lint

# Run type checking
pnpm type-check
```

## Troubleshooting

### Port Conflicts
```bash
# Check if port is in use
nc -z localhost $APP_PORT && echo "Port busy" || echo "Port available"

# If busy, increment base port by 100 and recalculate
```

### Docker Issues
```bash
# Rebuild containers
docker-compose build --no-cache

# Reset everything
docker-compose down -v
docker-compose up -d
```

### Worktree Issues
```bash
# Clean up stale worktrees
git worktree prune

# List all worktrees
git worktree list
```

## AI Visual Testing Setup

All agents must configure Playwright for screenshot-based AI testing:

```bash
# Install Playwright browsers
pnpm exec playwright install

# Test screenshot capability
pnpm exec playwright test --config=playwright.config.ts
```

Screenshots should be saved to `/tmp/screenshot_${AGENT_ID}_${timestamp}.png`

## VS Code Configuration

Recommended extensions:
- Svelte for VS Code
- TypeScript and JavaScript Language Features
- Prettier - Code formatter
- ESLint
- Tailwind CSS IntelliSense

## Project Structure

```
monitors/
├── src/
│   ├── lib/
│   │   ├── db/           # Database utilities
│   │   ├── ai/           # AI provider integrations
│   │   └── components/   # Reusable components
│   ├── routes/           # SvelteKit routes
│   └── app.html          # Main app template
├── prisma/               # Database schema and migrations
├── tests/                # Test files
├── docker-compose.yml    # Your customized version
└── coordination/         # Agent coordination files
```

## Lead Developer Enhanced Instructions

### Production-Ready Environment Setup
Based on successful backend developer implementation, here's the proven setup:

```bash
# CONFIRMED WORKING PROJECT STRUCTURE from be_claude_001_fc45
# This is the actual working setup that has been tested

# 1. Clone main repo to your workspace
mkdir -p /tmp/agent_workspaces/$AGENT_ID
cd /tmp/agent_workspaces/$AGENT_ID
cp -r /Users/davidcerezo/Projects/monitors/* .

# 2. Install dependencies (CONFIRMED WORKING)
pnpm install

# 3. Configure database with unique ports
export DB_PORT=$((5432 + ($(echo $AGENT_ID | cksum | cut -d' ' -f1) % 1000)))

# 4. Update docker-compose.yml with your ports
sed -i.bak "s/5432:5432/$DB_PORT:5432/g" docker-compose.yml

# 5. Create environment variables
cat > .env << EOF
DATABASE_URL="postgresql://postgres:password@localhost:$DB_PORT/monitors"
APP_PORT=$((5173 + ($(echo $AGENT_ID | cksum | cut -d' ' -f1) % 1000)))
AGENT_ID=$AGENT_ID
NODE_ENV=development
EOF

# 6. Start database and run migrations
docker compose up -d
sleep 10
pnpm db:generate
pnpm db:migrate

# 7. Start development server
pnpm dev
```

### Verified Dependencies (FROM WORKING SETUP)
```json
{
  "devDependencies": {
    "@sveltejs/adapter-vercel": "^4.0.0",
    "@sveltejs/kit": "^2.0.0",
    "@sveltejs/vite-plugin-svelte": "^3.0.0",
    "@types/bcrypt": "^5.0.0",
    "@types/jsonwebtoken": "^9.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.28.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-svelte": "^2.30.0",
    "prettier": "^3.0.0",
    "prettier-plugin-svelte": "^3.0.0",
    "prisma": "^5.6.0",
    "svelte": "^4.0.5",
    "svelte-check": "^3.4.3",
    "tslib": "^2.4.1",
    "tsx": "^4.0.0",
    "typescript": "^5.0.0",
    "vite": "^5.0.3",
    "vitest": "^1.0.0"
  },
  "dependencies": {
    "@prisma/client": "^5.6.0",
    "bcrypt": "^5.1.0",
    "jsonwebtoken": "^9.0.0",
    "zod": "^3.22.0"
  }
}
```

### Quality Assurance Checklist
Before claiming any development work as complete:

1. **Can you run `pnpm dev` without errors?**
2. **Can you connect to the database at your assigned port?**
3. **Do TypeScript checks pass with `pnpm check`?**
4. **Do linting checks pass with `pnpm lint`?**
5. **Can you generate Prisma client with `pnpm db:generate`?**

### Common Gotchas (REAL ISSUES FOUND)
- **Port conflicts**: Always verify your assigned ports are free
- **Database connection**: Wait for PostgreSQL to fully start before running migrations
- **Prisma generation**: Run `pnpm db:generate` after any schema changes
- **Environment isolation**: Never work in the main repo - always use your workspace

**LEAD DEVELOPER AUTHORITY**: Any environment setup that doesn't follow these proven patterns will be rejected. Use the working setup from be_claude_001_fc45 as the gold standard.

**Approved by**: ld_claude_002_w9k5  
**Date**: 2025-09-06T12:50:00Z  
**Based on**: Successful implementation by be_claude_001_fc45

DOCUMENT COMPLETE - LEAD DEVELOPER APPROVED