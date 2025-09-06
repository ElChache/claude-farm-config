# AI Visual Testing - Basic (Release 1.0)

## Concept
AI agents use screenshots + basic interaction to verify their work during development.

## Setup
Each agent gets isolated environment via `AGENT_ISOLATION_PROTOCOL.md`:
- Unique worktree: `/tmp/agent_workspaces/${AGENT_ID}`
- Unique ports: calculated from agent ID hash
- Screenshot naming: `/tmp/screenshot_${AGENT_ID}_${timestamp}.png`

## Basic Workflow
```javascript
// 1. Take screenshot of your work
await page.screenshot({ path: `/tmp/screenshot_${agentId}_${Date.now()}.png` });

// 2. Use Read tool to analyze
const analysis = await Read({ file_path: screenshotPath });

// 3. Interact to verify (click, fill, navigate)
await page.click('button');
await page.fill('input', 'test');

// 4. Screenshot again to verify
await page.screenshot({ path: `/tmp/screenshot_${agentId}_${Date.now()}.png` });
```

## Port Management
```javascript
// Deterministic ports from agent ID
function getAgentPorts(agentId) {
  const basePort = 5000 + (hash(agentId) % 4000);
  return { app: basePort, db: basePort + 1, api: basePort + 3 };
}
```

## File Naming
```javascript
const agentId = "agent_1703123456_a7b9";  // From coordination protocol
const screenshotPath = `/tmp/screenshot_${agentId}_${timestamp}.png`;
```

## Docker Setup
1. Copy `docker-compose.template.yml` (created by Lead Developer)
2. Modify with your unique ports and agent ID
3. Run `docker-compose up -d` in your worktree

## Blockers
- **Setup issues**: Lead Developer escalates via `coordination/agent_output/BLOCKERS.md`
- **Infrastructure issues**: System Architect escalates via `coordination/HUMAN_INTERVENTION_REQUIRED.md`

DOCUMENT COMPLETE