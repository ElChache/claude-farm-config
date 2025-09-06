# UX Expert Tasks

## Format: XML Communication Protocol
All task updates must follow the XML format specified in `COMMUNICATION_PROTOCOL.md`.

## Current Tasks

<!-- No active UX tasks -->

## Task Template
```xml
<task_update>
  <agent_id>agent_XXXXXXXXX_XXXX</agent_id>
  <role>ux_expert</role>
  <task_id>UX_YYYY_MM_DD_###</task_id>
  <title>Task Title</title>
  <status>planning|in_progress|testing|completed|blocked</status>
  <priority>high|medium|low</priority>
  <description>Detailed task description</description>
  <files_modified>
    <file>path/to/wireframes.md</file>
    <file>path/to/user_flows.md</file>
  </files_modified>
  <dependencies>
    <dependency>Product requirements or user research</dependency>
  </dependencies>
  <blockers>
    <blocker>Issue preventing progress</blocker>
  </blockers>
  <completion_criteria>
    <criterion>UX deliverable meets user needs</criterion>
    <criterion>Design system consistency maintained</criterion>
  </completion_criteria>
  <estimated_hours>X</estimated_hours>
  <actual_hours>Y</actual_hours>
  <timestamp>2025-09-06T02:34:00Z</timestamp>
</task_update>
```

## Coordination Rules

1. **Always check active_work_registry.json before claiming tasks**
2. **Create agent lock files before modifying any files**
3. **Update this file when starting/completing tasks**
4. **Follow UX role dependencies in role_ux_expert.md**
5. **Coordinate with graphic designer on visual consistency**