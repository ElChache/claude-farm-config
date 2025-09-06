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

**NOTE**: This is an initial bootstrap document. The Lead Developer will provide the official version with complete specifications.

DOCUMENT COMPLETE