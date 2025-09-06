# Graphic Design Tasks

## Format: XML Communication Protocol
All task updates must follow the XML format specified in `COMMUNICATION_PROTOCOL.md`.

## Current Tasks

<!-- No active graphic design tasks -->

## Task Template
```xml
<task_update>
  <agent_id>agent_XXXXXXXXX_XXXX</agent_id>
  <role>graphic_designer</role>
  <task_id>GD_YYYY_MM_DD_###</task_id>
  <title>Task Title</title>
  <status>planning|in_progress|testing|completed|blocked</status>
  <priority>high|medium|low</priority>
  <description>Detailed task description</description>
  <files_modified>
    <file>path/to/design_assets/logo.svg</file>
    <file>path/to/style_guide.md</file>
  </files_modified>
  <dependencies>
    <dependency>UX wireframes or brand requirements</dependency>
  </dependencies>
  <blockers>
    <blocker>Issue preventing progress</blocker>
  </blockers>
  <completion_criteria>
    <criterion>Visual design meets brand standards</criterion>
    <criterion>Assets exported in required formats</criterion>
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
4. **Follow graphic design role dependencies in role_graphic_designer.md**
5. **Coordinate with UX expert on design consistency**