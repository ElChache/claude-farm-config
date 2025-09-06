# Communication Protocol

## Two Communication Systems

There are **two distinct communication channels** for team coordination:

1. **Task Management Communication** - All task status updates, progress reporting, and task-related communication happens directly in TASKS files (AI_TASKS.md, BE_TASKS.md, FE_TASKS.md, etc.)

2. **General Team Communication** - Questions, guidance requests, and cross-team coordination happens in the shared `coordination/agent_output/FORUM.md`

---

## 1. Task Management Communication

**Example:** When you need to update a task status or ask about a specific task requirement, you update it directly in your TASKS file:

```xml
<task id="auth_api_001" status="needs_clarification">
  <title>Implement user authentication API</title>
  <assigned_to>backend_agent_1703123456_a7b9</assigned_to>
  
  <clarification status="pending">
    <question>Should the authentication use JWT tokens or session-based auth?</question>
    <answer>Use JWT tokens for better scalability and stateless authentication</answer>
  </clarification>
  
  <review status="passed">
    <from>lead_developer</from>
    <stamp>lead developer review passed</stamp>
  </review>
</task>
```

### Task Status Management

When working with tasks in your TASKS file:

**Available Task Status Values:**

```xml
<!-- Task lifecycle statuses -->
<task status="ready">        <!-- Task is ready to be claimed and started -->
<task status="in_progress">  <!-- Task is currently being worked on -->
<task status="needs_clarification"> <!-- Task description is unclear or incomplete -->
<task status="blocked">      <!-- Task cannot be started due to dependencies -->
<task status="needs_qa">     <!-- Task complete but requires QA testing -->
<task status="qa_blocked">   <!-- QA found issues that need to be addressed -->
<task status="done">         <!-- Task complete, branch pushed, PR created -->
<task status="review_blocked"> <!-- Lead Developer PR review failed -->

<!-- Special review stamps (added by Lead Developer) -->
<review status="passed">     <!-- PR approved, merged, and task complete -->
```

**How to Update Task Status:**
1. Select next task with status "ready"
2. Update task status based on your assessment:
   - Use **"in progress"** if task is clear and you can start work
   - Use **"needs clarification"** if task description is unclear or incomplete
   - Use **"blocked"** if task cannot be started due to dependencies or blockers
   - Use **"needs qa"** if task is complete but requires QA testing
   - Use **"done"** if task is complete and ready for final Lead Developer review

**Adding Questions or Concerns:**
If setting status to "needs clarification", "blocked", "qa blocked", or "review blocked", add your question/concern after the task description:
```
Question: [Your specific question or what needs clarification]
```

**Task vs. Bug Format:**
- Use **Task:** for new features and planned work
- Use **Bug:** for issues found during testing or development

### Sub-Task Management

**When to Create Sub-Tasks:**
System Architect creates feature-level tasks (3-8 hours) that developers can break down into smaller, manageable pieces. Developers should create sub-tasks when the original task is complex and benefits from being split into 1-hour chunks.

**Sub-Task Structure:**
```xml
<task id="main_task_001" status="in_progress">
  <title>Original System Architect task</title>
  <assigned_to>backend_agent_1703123456_a7b9</assigned_to>
  
  <subtasks>
    <subtask id="sub_001" status="done">
      <description>Sub-task 1 description</description>
    </subtask>
    <subtask id="sub_002" status="in_progress">  
      <description>Sub-task 2 description</description>
    </subtask>
    <subtask id="sub_003" status="ready">
      <description>Sub-task 3 description</description>
    </subtask>
  </subtasks>
  
  <current_focus>sub_002</current_focus>
</task>
```

**Sub-Task Rules:**
- Keep the original System Architect task intact - never modify or delete it
- Add sub-tasks as nested items under the main task
- Track which sub-task you're currently working on
- Only mark the main task as "done" when ALL sub-tasks are complete
- Lead Developer reviews only the main task, not individual sub-tasks

**Task Workflow Examples:**

**Example 1 - Task needing QA:**
```
Task: Build user registration form
Status: needs qa
QA Notes: Login validation works correctly, form styling matches design
Status: done
Lead Developer Review: lead developer review passed
```

**Example 2 - Task with QA issues:**
```
Task: Implement password reset
Status: needs qa
QA Notes: Password reset email not being sent
Status: qa blocked
Question: Email service integration appears to be failing, what SMTP settings should I use?
Answer: Use SendGrid with API key from environment variables
Status: done
Lead Developer Review: lead developer review passed
```

**Example 3 - Task with PR review issues:**
```
Task: Create API documentation
Status: done
PR: https://github.com/repo/pull/123
Lead Developer Review: review blocked
Feedback: PR missing error response examples and rate limiting details, please update code
Status: done  
PR: https://github.com/repo/pull/123 (updated)
Lead Developer Review: lead developer review passed (PR merged)
```

**Example 4 - Bug filed by QA:**
```
Bug: Login form accepts empty password (filed in FE_TASKS.md by QA)
Status: ready
Description: Password validation is not working, allows login with empty password field
Status: in progress
Status: done
Lead Developer Review: lead developer review passed
```

**Example 5 - Task with Sub-tasks:**
```
Task: Implement complete user authentication system
Status: in progress
Sub-tasks:
  - Sub-task 1: Create user registration API endpoint - Status: done
  - Sub-task 2: Build login/logout functionality - Status: done
  - Sub-task 3: Add password reset flow - Status: in progress
  - Sub-task 4: Implement JWT token validation middleware - Status: ready
  - Sub-task 5: Create user profile management - Status: ready
Current focus: Sub-task 3
Status: needs qa
Status: done
Lead Developer Review: lead developer review passed
```

---

## 2. General Team Communication (Forum)

**Example:** When you need to coordinate with another role or ask general questions, you post in the shared forum:

```xml
<message id="forum_001" status="pending">
  <to>BE</to>
  <from>frontend_agent_1703123456_a7b9</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <text>What's the expected response format for the /api/users endpoint?</text>
</message>

<reply id="forum_001" status="complete">
  <from>backend_agent_1703123457_x2k1</from>
  <timestamp>2024-01-15T10:15:00Z</timestamp>
  <text>The response will be JSON with { id, name, email, role, createdAt } fields</text>
</reply>
```

### Team Forum System

All team members use `coordination/agent_output/FORUM.md` to ask questions, seek guidance, and coordinate work across roles.

### Forum Format

**To Post a Question:**
```xml
<message id="unique_id" status="pending">
  <to>ROLE</to>  <!-- BE, AI, UX, GD, QA, etc. -->
  <from>your_agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <text>Your specific question or request</text>
</message>
```

**To Answer a Question:**
When you see a question addressed to your role, add your response:
```xml
<reply id="same_unique_id" status="complete">
  <from>your_agent_id</from>
  <timestamp>2024-01-15T10:15:00Z</timestamp>
  <text>Your response to the question</text>
</reply>
```

### Communication Rules

1. **Check Frequently**: Read `coordination/agent_output/FORUM.md` every few minutes while working to see if anyone has asked you questions or posted answers to your questions

2. **Be Specific**: Include specific details, file paths, or code examples when asking questions

3. **Respond Promptly**: Answer questions addressed to your role as quickly as possible to prevent blocking other team members

4. **Keep It Organized**: Always use the specified format and include the `---` separator between messages

5. **Stay Professional**: Keep communication focused on work coordination and project questions

### GitHub Integration Requirements

**All GitHub interactions must use the GitHub CLI tool (`gh`):**

- **Create PRs**: `gh pr create --title "Title" --body "Description" --assignee lead_developer`
- **Review PRs**: `gh pr review --approve` or `gh pr review --request-changes`
- **Merge PRs**: `gh pr merge --squash` or `gh pr merge --merge`
- **Check status**: `gh pr status`, `gh pr list`

**Installation**: Ensure `gh` is installed and authenticated in your development environment.

## 3. Human Intervention Communication

**Usage**: System Architect and Product Owner use `coordination/HUMAN_INTERVENTION_REQUIRED.md` to request human assistance for tasks requiring human-only capabilities.

### Human Intervention Format

**To Request Human Intervention:**
```xml
<intervention id="unique_id" status="pending" priority="high">
  <from>system_architect_agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <type>technical</type> <!-- technical, business, auth, integration -->
  
  <description>GitHub CLI cannot create PRs - authentication failing</description>
  <context>Testing PR workflow during Phase 1 architecture completion</context>
  <required_action>Fix GitHub CLI authentication and permissions</required_action>
  <impact>All development agents cannot submit PRs for review</impact>
</intervention>
```

**Human Response:**
```xml
<resolution id="same_unique_id" status="complete">
  <from>Human</from>
  <timestamp>2024-01-15T10:30:00Z</timestamp>
  <action_taken>Updated GitHub CLI auth token and repository permissions</action_taken>
  <notes>Agents should now be able to create and merge PRs</notes>
</resolution>
```

### CRITICAL: Human Intervention File Creation Protocol

**⚠️ MANDATORY VERIFICATION**: When creating or updating `HUMAN_INTERVENTION_REQUIRED.md`, you MUST follow this exact protocol to prevent claiming file creation without actually doing it:

**Step 1: Create/Update the File**
Use the Write or Edit tool to create/update the file with the proper XML template.

**Step 2: Immediate Verification**
After file creation, you MUST immediately run these verification commands:
```bash
ls -la coordination/HUMAN_INTERVENTION_REQUIRED.md
wc -l coordination/HUMAN_INTERVENTION_REQUIRED.md  
head -5 coordination/HUMAN_INTERVENTION_REQUIRED.md
```

**Step 3: Proof in Status Message**
Include the verification command output in your status message as proof:
```xml
<message id="intervention_created" status="complete">
  <from>sa_arch_001_m6k3</from>
  <text>✅ HUMAN_INTERVENTION_REQUIRED.md created and verified:

File exists: -rw-r--r--  1 user  staff  324 Jan 06 15:30 coordination/HUMAN_INTERVENTION_REQUIRED.md
Line count: 12 coordination/HUMAN_INTERVENTION_REQUIRED.md
Content preview:
&lt;intervention id="gh_cli_001" status="pending" priority="high"&gt;
  &lt;from&gt;sa_arch_001_m6k3&lt;/from&gt;
  &lt;timestamp&gt;2025-01-06T15:30:00Z&lt;/timestamp&gt;
  &lt;type&gt;technical&lt;/type&gt;
  &lt;description&gt;GitHub CLI cannot create PRs&lt;/description&gt;
  </text>
</message>
```

**Step 4: No Claims Without Proof**
❌ **NEVER** claim file creation without showing verification output
❌ **NEVER** say "Added to HUMAN_INTERVENTION_REQUIRED.md" without proof
✅ **ALWAYS** show the file exists and contains the expected content

## 4. Blocker Communication

**Usage**: Lead Developer and other team members use `coordination/agent_output/BLOCKERS.md` to escalate issues requiring Product Owner attention.

### Blocker Format

**To Report a Blocker:**
```xml
<blocker id="unique_id" status="pending" priority="high">
  <from>lead_developer_agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <type>product</type> <!-- product, business, clarification, technical -->
  
  <description>Brief description of the blocker</description>
  <context>What you were trying to accomplish</context>
  <attempted_solutions>What you tried, who you asked</attempted_solutions>
  <required_action>Specific action needed from Product Owner</required_action>
  <impact>What's blocked until resolved</impact>
</blocker>
```

**Product Owner Response:**
```xml
<resolution id="same_unique_id" status="complete">
  <from>product_owner_agent_id</from>
  <timestamp>2024-01-15T10:45:00Z</timestamp>
  <decision>Clarification or decision made</decision>
  <action_taken>Specific actions taken to resolve blocker</action_taken>
</resolution>
```

### Document Completion Standards

**All coordination documents must include completion markers:**

- **"DOCUMENT COMPLETE"** - Add this exact phrase at the end of every coordination document when finished
- **Purpose**: Signals to dependent roles that the document is ready for their review
- **Dependencies**: Other roles wait for this marker before proceeding with their work
- **Examples of documents requiring completion markers**:
  - `coordination/PRODUCT_SPECIFICATION.md`
  - `coordination/agent_output/SYSTEM_ARCHITECTURE.md`
  - `coordination/agent_output/IMPLEMENTATION_PLAN.md`
  - `coordination/TECHNICAL_STANDARDS.md`
  - `coordination/agent_output/DEVELOPMENT_ENVIRONMENT_SETUP.md`
  - All TASKS files when initially created

---

## 3. Role and File Reference

### Role Abbreviations and Task Files

| Role | Abbreviation | TASKS File to check |
|------|--------------|------------|
| Backend Developer | **BE** | `coordination/agent_output/BE_TASKS.md` |
| Frontend Developer | **FE** | `coordination/agent_output/FE_TASKS.md` |
| AI Developer | **AI** | `coordination/agent_output/AI_TASKS.md` |
| UX Expert | **UX** | `coordination/agent_output/UX_TASKS.md` |
| Graphic Designer | **GD** | `coordination/agent_output/GD_TASKS.md` |
| Technical QA | **QA** | `coordination/agent_output/QA_TASKS.md` |
| Product Owner | **PM** | No TASKS file (creates requirements) |
| System Architect | **SA** | No TASKS file (creates architecture) |
| Lead Developer | **LD** | No TASKS file (creates and reviews all TASKS files) |

### Forum Communication Purpose

This forum system enables:
- Quick clarification of requirements
- Coordination on dependencies
- Resolution of project questions  
- Prevention of work blocking
- Clear audit trail of decisions

Remember: Effective communication prevents delays and ensures all team members stay aligned on project progress.