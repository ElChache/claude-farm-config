# Agent Farm Coordination Protocol

## Project Overview

This coordination protocol enables multiple AI agents to collaborate on building your application. The Product Owner will provide detailed project specifications in `PROJECT_SPECIFICATION.md` that all agents should reference for project-specific requirements.

**Tech Stack**: SvelteKit + TypeScript + PostgreSQL + Vercel  
**Additional Technologies**: As specified in PROJECT_SPECIFICATION.md

## CRITICAL: Environment Isolation Required

**MANDATORY READING**: Before claiming any development role, you MUST read and follow `coordination/AGENT_ISOLATION_PROTOCOL.md` to prevent conflicts with other agents working simultaneously.

All development agents (Frontend, Backend, AI, QA) must use isolated git worktrees and unique Docker Compose environments to avoid port conflicts, file collisions, and database conflicts.

## Role Assignment Protocol

### Roles Schema (Zod)
```typescript
import { z } from 'zod';

const RolesSchema = z.object({
  product_owner: z.string().nullable(),           // exactly 1
  system_architect: z.string().nullable(),       // exactly 1  
  ux_expert: z.string().nullable(),              // exactly 1
  graphic_designer: z.string().nullable(),       // exactly 1
  lead_developer: z.string().nullable(),         // exactly 1
  backend_developers: z.array(z.string()).max(3).min(0),    // 0-3
  frontend_developers: z.array(z.string()).max(2).min(0),   // 0-2
  ai_developers: z.array(z.string()).max(2).min(0),         // 0-2
  technical_qa: z.string().nullable(),           // exactly 1
});
```

### Assignment Process
**FIRST COME, FIRST TAKE** - When you start:

1. **Check** `/coordination/roles.json`
2. **Claim** first available role (update JSON with your agent ID)
3. **Read** your specific role file (see mapping below)
4. **Start working** following your role's dependencies

### Role File Mapping
Each role must read their specific instructions file:

- **product_owner** → `coordination/role_product_owner.md`
- **system_architect** → `coordination/role_system_architect.md`
- **ux_expert** → `coordination/role_ux_expert.md`
- **graphic_designer** → `coordination/role_graphic_designer.md`
- **lead_developer** → `coordination/role_lead_developer.md`
- **backend_developers** → `coordination/role_backend_developer.md`
- **frontend_developers** → `coordination/role_frontend_developer.md`
- **ai_developers** → `coordination/role_ai_developer.md`
- **technical_qa** → `coordination/role_technical_qa.md`

### Role Dependencies
**Each role file contains specific dependencies - check your individual role file for:**
- Who you wait for before starting
- What deliverables you need to review
- Who reviews your completed work

## CRITICAL: Multi-Agent Coordination Protocol

### Before Starting ANY Work

1. **Check the Agent Coordination System:**
   ```
   /coordination/
   ├── roles.json                           # Role assignments
   ├── active_work_registry.json            # Central registry of all active work
   ├── completed_work_log.json              # Log of completed tasks
   ├── agent_locks/                         # Directory for individual agent locks
   │   └── {agent_id}_{timestamp}.lock
   ├── verification_reports/                # Phase completion proofs
   ├── blockers.json                       # Current issues/blockers
   ├── planned_work_queue.json             # Queue of planned but not started work
   │
   ├── COMMUNICATION_PROTOCOL.md           # XML communication formats - READ THIS!
   ├── AGENT_ISOLATION_PROTOCOL.md         # Git worktree + Docker isolation - READ THIS!
   ├── AI_VISUAL_TESTING_SPECIFICATION.md  # Visual testing overview
   ├── AI_VISUAL_TESTING_BASIC.md          # Release 1.0 visual testing
   ├── AI_VISUAL_TESTING_INTERACTIVE.md    # Future visual testing
   │
   ├── FORUM.md                            # Team communication (XML format)
   ├── BLOCKERS.md                         # Team blockers (XML format)
   ├── HUMAN_INTERVENTION_REQUIRED.md      # Human escalations (XML format)
   │
   ├── BE_TASKS.md                         # Backend tasks (XML format)
   ├── FE_TASKS.md                         # Frontend tasks (XML format)
   ├── AI_TASKS.md                         # AI tasks (XML format)
   ├── UX_TASKS.md                         # UX tasks (XML format)
   ├── GD_TASKS.md                         # Graphic design tasks (XML format)
   ├── QA_TASKS.md                         # QA tasks (XML format)
   │
   └── role_*.md                           # Individual role instructions
   ```

2. **MANDATORY READING - Read these files immediately:**
   - `coordination/agent_output/COMMUNICATION_PROTOCOL.md` - Learn XML communication formats
   - `coordination/AGENT_ISOLATION_PROTOCOL.md` - Set up your isolated environment
   - `coordination/AI_VISUAL_TESTING_BASIC.md` - Learn visual testing with screenshots
   - Your assigned role file (`coordination/role_*.md`) - Get your specific instructions

3. **Generate Agent ID:**
   - Create role-based agent ID: `{role_prefix}_{type}_{sequence}_{4_random_chars}`
   - Examples: `be_primary_001_a7b9`, `fe_support_002_x8m2`, `ai_claude_001_p3k7`
   - Role prefixes: `be` (backend), `fe` (frontend), `ai` (AI dev), `qa` (QA), `sa` (system architect), `pm` (product owner), `ux` (UX expert), `gd` (graphic designer), `ld` (lead developer)
   - Types: `primary`, `support`, `specialist`, `claude`, `openai`, etc.
   - Use this ID consistently throughout your work

3. **Claim Your Work BEFORE Planning:**
   - Check `active_work_registry.json` for conflicts
   - Create a lock file in `agent_locks/` with:
     ```json
     {
       "agent_id": "your_agent_id",
       "timestamp": "ISO_8601_timestamp",
       "planned_scope": {
         "files": ["list", "of", "files", "you", "plan", "to", "modify"],
         "features": ["features", "or", "deliverables", "to", "implement"],
         "estimated_duration": "minutes"
       },
       "status": "planning|implementing|testing|completed"
     }
     ```

### Work Registration Process

#### Step 1: Pre-Work Check
1. Run this check sequence:
   - List all files in `/coordination/agent_locks/`
   - Parse `active_work_registry.json`
   - Identify any overlapping files or features
   - Check `completed_work_log.json` to avoid redoing work

#### Step 2: Register Your Intent
1. Create your work plan in `/coordination/planned_work/{agent_id}_plan.md`
2. Update `active_work_registry.json`:
   ```json
   {
     "agent_id": {
       "start_time": "timestamp",
       "files_locked": ["file1.ts", "file2.svelte"],
       "features_working_on": ["authentication", "user_dashboard"],
       "plan_file": "path/to/plan.md",
       "expected_completion": "timestamp"
     }
   }
   ```

#### Step 3: During Work
- Update your lock file status every 30 minutes
- If you need additional files, check and lock them first
- If you encounter conflicts, STOP and reassess

#### Step 4: Work Completion
1. Update `completed_work_log.json` with:
   - Summary of changes
   - Files modified
   - Features implemented
   - Git commit hash
2. Remove your entry from `active_work_registry.json`
3. Delete your lock file from `agent_locks/`

### Conflict Resolution Protocol

**If files/features you want to work on are already locked:**
- Check the timestamp - if older than 1 hour, consider it stale
- Look for alternative, non-conflicting work
- Add your plan to `planned_work_queue.json` for later
- **Never proceed if another agent has an active lock on your target files**

### File Locking Protocol

Before modifying ANY file:
1. Check `/coordination/agent_locks/` for existing locks
2. Create lock file: `/coordination/agent_locks/{agent_id}_{filename}.lock`
3. Include in lock file:
   ```json
   {
     "agent_id": "your_id",
     "file": "path/to/file", 
     "started_at": "ISO_timestamp",
     "estimated_completion": "ISO_timestamp",
     "task": "brief description"
   }
   ```
4. Remove lock when done
5. **Never modify files locked by other agents**
6. Locks older than 3 hours are stale - document and proceed with caution

### Work Registry Management

Update `/coordination/active_work_registry.json` when starting/completing work:

```json
{
  "active_work": {
    "agent_123": {
      "role": "backend_developer",
      "current_task": "Database schema implementation", 
      "files_locked": ["src/lib/db/schema.sql"],
      "started_at": "2025-01-03T10:00:00Z",
      "estimated_completion": "2025-01-03T13:00:00Z",
      "status": "in_progress"
    }
  }
}
```

### Conflict Resolution

**If you find conflicts:**
1. **Stop immediately** - don't modify conflicting files
2. **Document conflict** in `/coordination/agent_output/BLOCKERS.json`
3. **Choose alternative task** - work on non-conflicting files  
4. **Wait for resolution** - check every 30 minutes
5. **Never force-override** another agent's work

**If you find stale locks (3+ hours old):**
1. Document in `/coordination/stale_locks_found.log`
2. Move to `/coordination/stale_locks/`
3. Check git history for recent changes
4. Proceed with caution

### Communication Standards

**Developer Communication:** All inter-role communication follows `coordination/agent_output/COMMUNICATION_PROTOCOL.md` - read this file for detailed forum system instructions.

**Git Commit Format:**
```
[ROLE] Task: Brief description

- Specific change 1
- Specific change 2

Chunk: {chunk_id_from_plan}
Files: {files_modified}
```

**Status Updates:**
- Update registry when starting/pausing/completing work
- Document blockers immediately when found
- Alert team of breaking changes before making them

### Project Success

Each role has specific success criteria defined in their individual role files that contribute to overall project completion.

---

## Getting Started

1. **Check your role**: Read `/coordination/roles.json`
2. **Claim available role**: Update JSON with your agent ID  
3. **Read role instructions**: Open `role_{your_role}.md`
4. **Check dependencies**: Ensure prerequisites are met
5. **Start working**: Follow your role's specific instructions
6. **Update coordination**: Keep registry and logs current

Remember: This is about building a functional application that actually works, not just code that compiles. Focus on user value and system reliability.