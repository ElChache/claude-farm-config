# Technical QA Tasks

## Format: XML Communication Protocol
All task updates must follow the XML format specified in `COMMUNICATION_PROTOCOL.md`.

## Current Tasks

<!-- No active QA tasks -->

## Task Template
```xml
<task_update>
  <agent_id>agent_XXXXXXXXX_XXXX</agent_id>
  <role>technical_qa</role>
  <task_id>QA_YYYY_MM_DD_###</task_id>
  <title>Task Title</title>
  <status>planning|in_progress|testing|completed|blocked</status>
  <priority>high|medium|low</priority>
  <description>Detailed task description</description>
  <files_modified>
    <file>path/to/test_suite.ts</file>
    <file>path/to/test_report.md</file>
  </files_modified>
  <dependencies>
    <dependency>Feature implementation or test requirements</dependency>
  </dependencies>
  <blockers>
    <blocker>Issue preventing progress</blocker>
  </blockers>
  <completion_criteria>
    <criterion>Test coverage meets requirements</criterion>
    <criterion>All tests pass consistently</criterion>
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
4. **Follow QA role dependencies in role_technical_qa.md**
5. **Use isolated git worktrees per AGENT_ISOLATION_PROTOCOL.md**
6. **Coordinate visual testing per AI_VISUAL_TESTING_BASIC.md**