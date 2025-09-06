# Agent Isolation Protocol

## Critical Development Requirement

**MANDATORY**: All development agents MUST follow this isolation protocol to prevent conflicts when working simultaneously on the same codebase.

## Core Problem

Multiple AI agents working on the same project simultaneously will create conflicts:
- File editing collisions
- Docker Compose port conflicts  
- Git branch conflicts
- Database conflicts
- Screenshot file conflicts

## Solution: Complete Agent Isolation

Each agent gets their own isolated development environment using **Git Worktree** + **Deterministic Port Assignment**.

## Git Worktree Setup (REQUIRED)

### Step 1: Create Your Isolated Workspace

```bash
# Generate your unique agent ID first (from coordination protocol)
AGENT_ID="agent_$(date +%s)_$(openssl rand -hex 2)"  # e.g., agent_1703123456_a7b9

# Create isolated worktree with your own branch
git worktree add /tmp/agent_workspaces/$AGENT_ID -b ${AGENT_ID}_work

# Navigate to your isolated workspace
cd /tmp/agent_workspaces/$AGENT_ID

# You now have complete isolation - modify any files without conflicts!
```

### Step 2: Verify Your Isolation

```bash
# Check your branch
git branch  # Should show: * agent_1703123456_a7b9_work

# Check your workspace
pwd  # Should show: /tmp/agent_workspaces/agent_1703123456_a7b9

# You have a complete copy of the codebase - work freely!
ls -la  # src/, package.json, docker-compose.yml, etc.
```

## Docker Compose Port Management (REQUIRED)

### Deterministic Port Assignment

Each agent gets unique ports based on their agent ID to prevent conflicts:

```javascript
// Port calculation algorithm (implement this logic)
function getAgentPorts(agentId) {
  // Simple hash function for consistent port assignment
  let hash = 0;
  for (let i = 0; i < agentId.length; i++) {
    hash = ((hash << 5) - hash + agentId.charCodeAt(i)) & 0xffffffff;
  }
  
  // Convert to positive number and get base port (range: 5000-8999)
  const basePort = 5000 + (Math.abs(hash) % 4000);
  
  return {
    app: basePort,           // Frontend development server
    db: basePort + 1,        // PostgreSQL database  
    redis: basePort + 2,     // Redis cache (if needed)
    api: basePort + 3,       // Backend API server
    playwright: basePort + 4 // Playwright debug port
  };
}

// Example for agent_1703123456_a7b9:
// app: 5347, db: 5348, redis: 5349, api: 5350, playwright: 5351
```

### Dynamic Docker Compose Generation

**IMPORTANT**: The Lead Developer will create the actual `docker-compose.template.yml` file. You must copy this template and modify it for your isolated environment.

```bash
# In your worktree workspace: /tmp/agent_workspaces/$AGENT_ID
# Copy the template created by Lead Developer
cp docker-compose.template.yml docker-compose.yml

# Then modify YOUR copy with your unique ports
# The example below shows what the template might look like:
# (This is just an EXAMPLE - use the actual template created by Lead Developer)

cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    build: .
    ports:
      - "${APP_PORT}:5173"  # Replace with your calculated port
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:password@db:5432/monitors_${AGENT_ID}
      - AGENT_ID=${AGENT_ID}  # Replace with your actual agent ID
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db

  db:
    image: postgres:15
    ports:
      - "${DB_PORT}:5432"   # Replace with your calculated port
    environment:
      - POSTGRES_DB=monitors_${AGENT_ID}  # Replace with your actual agent ID
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_HOST_AUTH_METHOD=trust
    volumes:
      - postgres_data_${AGENT_ID}:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "${REDIS_PORT}:6379" # Replace with your calculated port
    volumes:
      - redis_data_${AGENT_ID}:/data

volumes:
  postgres_data_${AGENT_ID}:  # Replace with your actual agent ID
  redis_data_${AGENT_ID}:     # Replace with your actual agent ID
EOF

# Remember: This is just an example! Use the actual docker-compose.template.yml from Lead Developer
```

### Environment Variables Setup

Create your agent-specific .env file:

```bash
# Calculate your ports (implement the algorithm above)
AGENT_ID="agent_1703123456_a7b9"  # Your actual agent ID
APP_PORT=5347      # Calculated from your agent ID
DB_PORT=5348       # APP_PORT + 1
REDIS_PORT=5349    # APP_PORT + 2
API_PORT=5350      # APP_PORT + 3
PLAYWRIGHT_PORT=5351  # APP_PORT + 4

# Database connection
DATABASE_URL=postgresql://postgres:password@localhost:${DB_PORT}/monitors_${AGENT_ID}

# Agent identification
AGENT_ID=${AGENT_ID}
```

## Port Conflict Resolution

If your calculated ports are busy (rare but possible):

```bash
# Test if your port is available
nc -z localhost $APP_PORT && echo "Port busy" || echo "Port available"

# If busy, increment base port by 100 and recalculate
# This gives you a new range: 5447, 5448, 5449, 5450, 5451
```

## Complete Workflow Example

```bash
# 1. Generate agent ID and create workspace
AGENT_ID="agent_$(date +%s)_$(openssl rand -hex 2)"
git worktree add /tmp/agent_workspaces/$AGENT_ID -b ${AGENT_ID}_work
cd /tmp/agent_workspaces/$AGENT_ID

# 2. Calculate your ports (use the algorithm above)
# For this example: APP_PORT=5347, DB_PORT=5348, etc.

# 3. Copy docker-compose.template.yml and customize it with your ports and agent ID

# 4. Start your isolated environment
docker-compose up -d

# 5. Your development server is now running on YOUR unique ports
# Frontend: http://localhost:5347
# Database: localhost:5348
# Redis: localhost:5349

# 6. Work normally - no conflicts with other agents!
# - Edit any files
# - Run tests
# - Take screenshots at /tmp/screenshot_${AGENT_ID}_${timestamp}.png

# 7. When done, commit, push, and create PR for Lead Developer review
git add .
git commit -m "Implement feature X"
git push origin ${AGENT_ID}_work

# Create PR for Lead Developer review (using GitHub CLI)
gh pr create --title "Implement feature X" --body "Task completed, ready for review" --assignee lead_developer

# 8. Cleanup (optional)
cd /
docker-compose down
git worktree remove /tmp/agent_workspaces/$AGENT_ID
```

## AI Visual Testing Integration

Your screenshot files will be completely isolated:

```javascript
// In your agent workspace
const agentId = "agent_1703123456_a7b9";  // Your unique ID
const timestamp = Date.now();
const screenshotPath = `/tmp/screenshot_${agentId}_${timestamp}.png`;

// Playwright connects to YOUR isolated environment
await page.goto(`http://localhost:${APP_PORT}`);  // Your unique app port
await page.screenshot({ path: screenshotPath });
```

## Benefits of This Isolation

✅ **Zero Conflicts**: Each agent has completely separate environment  
✅ **Parallel Development**: All agents can work simultaneously  
✅ **Independent Testing**: Each agent tests against their own database/services  
✅ **Clean Merges**: Work in isolated branches, merge when ready  
✅ **Easy Cleanup**: Remove worktree when done, no trace left  
✅ **Resource Isolation**: Each agent has their own Docker containers and data  

## Workspace Cleanup

When your work is complete:

```bash
# Stop your services
docker-compose down

# Remove volumes if desired (optional - saves disk space)
docker-compose down -v

# Remove your worktree (from main repo directory)
cd /path/to/main/repo
git worktree remove /tmp/agent_workspaces/$AGENT_ID

# Your branch remains in git for merging/PR creation
```

## Troubleshooting

### Port Already in Use
```bash
# Find what's using your port
lsof -i :5347

# Kill the process (if safe to do so)
kill -9 <PID>

# Or increment your base port by 100 and recalculate
```

### Worktree Creation Failed
```bash
# Clean up any partial worktree
git worktree prune

# Try again with fresh agent ID
AGENT_ID="agent_$(date +%s)_$(openssl rand -hex 2)"
```

### Docker Compose Issues
```bash
# Ensure you're in your agent workspace
pwd  # Should be: /tmp/agent_workspaces/your_agent_id

# Rebuild if needed
docker-compose build --no-cache
docker-compose up -d
```

## Critical Rules

1. **NEVER work in the main repository directory** - always use your worktree
2. **ALWAYS use your calculated ports** - never hardcode port numbers
3. **ALWAYS include your agent ID in file names** (screenshots, logs, etc.)
4. **ALWAYS clean up your worktree** when work is complete
5. **NEVER modify another agent's workspace or branch**

This protocol ensures complete isolation between agents while maintaining full development capabilities.

DOCUMENT COMPLETE