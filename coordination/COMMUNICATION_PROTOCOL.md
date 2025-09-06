# Communication Protocol

## Two Communication Systems

1. Task Management Communication - Status updates in TASKS files (AI_TASKS.md, BE_TASKS.md, FE_TASKS.md, etc.)
2. General Team Communication - Questions/coordination in shared `coordination/agent_output/FORUM.md`

---

## 1. Task Management Communication

### Task Status Values
```xml
<task status="ready">             <!-- Ready to claim and start -->
<task status="in_progress">       <!-- Currently being worked on -->
<task status="needs_clarification"> <!-- Task unclear/incomplete -->
<task status="blocked">           <!-- Cannot start due to dependencies -->
<task status="needs_qa">          <!-- Complete but requires QA testing -->
<task status="qa_blocked">        <!-- QA found issues to address -->
<task status="done">              <!-- Complete, branch pushed, PR created -->
<task status="review_blocked">    <!-- Lead Developer PR review failed -->

<review status="passed">          <!-- PR approved, merged by Lead Developer -->
```

### Task Update Format
```xml
<task id="task_id_001" status="in_progress">
  <title>Task Title</title>
  <assigned_to>agent_id_123</assigned_to>
  
  <!-- Add when status is needs_clarification/blocked/qa_blocked/review_blocked -->
  <question>Specific question or concern</question>
  <answer>Response to question</answer>
  
  <!-- Lead Developer adds after PR review -->
  <review status="passed">
    <from>lead_developer</from>
    <stamp>lead developer review passed</stamp>
  </review>
</task>
```

### Status Update Rules
1. Select task with status "ready"
2. Update based on assessment:
   - "in_progress" if clear and can start
   - "needs_clarification" if unclear/incomplete
   - "blocked" if dependencies prevent start
   - "needs_qa" if complete but needs QA testing
   - "done" if complete and ready for Lead Developer review

### Task vs Bug Format
- Task: for new features and planned work
- Bug: for issues found during testing or development

### Sub-Task Management

When to Create Sub-Tasks: System Architect creates feature-level tasks (3-8 hours) that developers can break down into smaller 1-hour pieces.

Sub-Task Structure:
```xml
<task id="main_task_001" status="in_progress">
  <title>Original System Architect task</title>
  <assigned_to>agent_id</assigned_to>
  
  <subtasks>
    <subtask id="sub_001" status="done">
      <description>Sub-task 1 description</description>
    </subtask>
    <subtask id="sub_002" status="in_progress">
      <description>Sub-task 2 description</description>
    </subtask>
  </subtasks>
  
  <current_focus>sub_002</current_focus>
</task>
```

Sub-Task Rules:
- Never modify original System Architect task
- Only mark main task "done" when ALL sub-tasks complete
- Lead Developer reviews main task only, not sub-tasks

### Task Workflow Examples

Basic Flow:
```
Status: ready → in_progress → done → Lead Developer Review: lead developer review passed
```

With QA:
```
Status: ready → in_progress → needs_qa → done → Lead Developer Review: lead developer review passed
```

With QA Issues:
```
Status: ready → in_progress → needs_qa → qa_blocked
Question: Email service failing, what SMTP settings?
Answer: Use SendGrid with API key from env
Status: done → Lead Developer Review: lead developer review passed
```

With PR Review Issues:
```
Status: done
Lead Developer Review: review blocked
Feedback: Missing error response examples
Status: done (updated)
Lead Developer Review: lead developer review passed
```

---

## 2. General Team Communication (Forum)

### Forum Format

To Post Question:
```xml
<message id="unique_id" status="pending">
  <to>BE</to>  <!-- BE, AI, UX, GD, QA, etc. -->
  <from>your_agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <text>Your specific question</text>
</message>
```

To Answer Question:
```xml
<reply id="same_unique_id" status="complete">
  <from>your_agent_id</from>
  <timestamp>2024-01-15T10:15:00Z</timestamp>
  <text>Your response</text>
</reply>
```

### Forum Rules
1. Check `coordination/agent_output/FORUM.md` every few minutes
2. Include specific details, file paths, code examples
3. Respond promptly to questions for your role
4. Use specified format with `---` separators
5. Keep communication work-focused

### GitHub Integration
All GitHub interactions use GitHub CLI (`gh`):
- Create PRs: `gh pr create --title "Title" --body "Description"`
- Review PRs: `gh pr review --approve` or `gh pr review --request-changes`
- Merge PRs: `gh pr merge --squash`
- Check status: `gh pr status`, `gh pr list`

## 3. Human Intervention Communication

Usage: System Architect and Product Owner use `coordination/HUMAN_INTERVENTION_REQUIRED.md` to request human assistance.

### Human Intervention Format
```xml
<intervention id="unique_id" status="pending" priority="high">
  <from>agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <type>technical</type> <!-- technical, business, auth, integration -->
  
  <description>Brief issue description</description>
  <context>What you were trying to accomplish</context>
  <required_action>Specific action needed</required_action>
  <impact>What's blocked until resolved</impact>
</intervention>
```

### CRITICAL: File Creation Verification
MANDATORY when creating/updating `HUMAN_INTERVENTION_REQUIRED.md`:

1. Create/update file with Write/Edit tool
2. Immediately verify with:
```bash
ls -la coordination/HUMAN_INTERVENTION_REQUIRED.md
wc -l coordination/HUMAN_INTERVENTION_REQUIRED.md
head -5 coordination/HUMAN_INTERVENTION_REQUIRED.md
```
3. Include verification output in status message as proof
4. Never claim file creation without showing verification output

## 4. Blocker Communication

Usage: Lead Developer and team members use `coordination/agent_output/BLOCKERS.md` to escalate issues requiring Product Owner attention.

### Blocker Format
```xml
<blocker id="unique_id" status="pending" priority="high">
  <from>agent_id</from>
  <timestamp>2024-01-15T10:00:00Z</timestamp>
  <type>product</type> <!-- product, business, clarification, technical -->
  
  <description>Brief blocker description</description>
  <context>What you were trying to accomplish</context>
  <attempted_solutions>What you tried, who you asked</attempted_solutions>
  <required_action>Specific action needed from Product Owner</required_action>
  <impact>What's blocked until resolved</impact>
</blocker>
```

---

## 5. Document Completion Standards

All coordination documents must end with:
```
DOCUMENT COMPLETE
```

Required for:
- `coordination/PRODUCT_SPECIFICATION.md`
- `coordination/agent_output/SYSTEM_ARCHITECTURE.md`
- `coordination/agent_output/IMPLEMENTATION_PLAN.md`
- `coordination/TECHNICAL_STANDARDS.md`
- `coordination/agent_output/DEVELOPMENT_ENVIRONMENT_SETUP.md`
- All TASKS files when initially created

---

## 6. Role Reference

| Role | Code | TASKS File |
|------|------|------------|
| Backend Developer | BE | `coordination/agent_output/BE_TASKS.md` |
| Frontend Developer | FE | `coordination/agent_output/FE_TASKS.md` |
| AI Developer | AI | `coordination/agent_output/AI_TASKS.md` |
| UX Expert | UX | `coordination/agent_output/UX_TASKS.md` |
| Graphic Designer | GD | `coordination/agent_output/GD_TASKS.md` |
| Technical QA | QA | `coordination/agent_output/QA_TASKS.md` |
| Product Owner | PM | (Creates requirements) |
| System Architect | SA | (Creates architecture) |
| Lead Developer | LD | (Reviews all work) |

DOCUMENT COMPLETE