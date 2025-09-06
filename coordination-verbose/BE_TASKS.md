# Backend Development Tasks

## Format: XML Communication Protocol
All task updates must follow the XML format specified in `COMMUNICATION_PROTOCOL.md`.

## Current Tasks

<task id="BE_2025_09_06_001" status="ready">
  <title>Database Schema Design - Core Tables</title>
  <assigned_to>unassigned</assigned_to>
  <priority>critical</priority>
  <description>Design and implement core database schema including Users, Monitors, Facts, Evaluations, and Notifications tables. Create Prisma schema with proper relationships, indexes, and constraints based on PROJECT_SPECIFICATION.md requirements.</description>
  <files_to_modify>
    <file>prisma/schema.prisma</file>
    <file>prisma/migrations/</file>
  </files_to_modify>
  <dependencies>
    <dependency>TECHNICAL_STANDARDS.md (Complete)</dependency>
    <dependency>DEVELOPMENT_ENVIRONMENT_SETUP.md (Complete)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>Users table with authentication fields</criterion>
    <criterion>Monitors table with prompt, metadata, status fields</criterion>
    <criterion>Facts table with TTL and caching support</criterion>
    <criterion>Evaluations table with AI response history</criterion>
    <criterion>Notifications table with delivery tracking</criterion>
    <criterion>Proper foreign key relationships and indexes</criterion>
    <criterion>Migration files generated and tested</criterion>
  </completion_criteria>
  <estimated_hours>6</estimated_hours>
</task>

<task id="BE_2025_09_06_002" status="in_progress">
  <title>Authentication API Foundation</title>
  <assigned_to>agent_1757152189_dev2</assigned_to>
  <priority>critical</priority>
  <description>Implement user authentication system with email/password registration, login, and session management. Set up NextAuth.js/Auth.js integration with secure JWT tokens and password hashing.</description>
  <files_to_modify>
    <file>src/lib/auth.ts</file>
    <file>src/routes/api/auth/+server.ts</file>
    <file>src/hooks.server.ts</file>
    <file>src/lib/db/users.ts</file>
  </files_to_modify>
  <dependencies>
    <dependency>BE_2025_09_06_001 - Database Schema (blocking)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>User registration with email/password</criterion>
    <criterion>Secure password hashing (bcrypt)</criterion>
    <criterion>Login/logout functionality</criterion>
    <criterion>Session management with JWT</criterion>
    <criterion>Protected route middleware</criterion>
    <criterion>Basic user profile endpoints</criterion>
  </completion_criteria>
  <estimated_hours>8</estimated_hours>
</task>

<task id="BE_2025_09_06_003" status="in_progress">
  <title>AI Provider Abstraction Layer</title>
  <assigned_to>agent_1757152188_6f2a</assigned_to>
  <priority>critical</priority>
  <description>Create unified AI provider interface supporting Claude (primary) and OpenAI (fallback). Implement provider routing, error handling, retry mechanisms, and response format normalization for monitor evaluation.</description>
  <files_to_modify>
    <file>src/lib/ai/providers/base.ts</file>
    <file>src/lib/ai/providers/claude.ts</file>
    <file>src/lib/ai/providers/openai.ts</file>
    <file>src/lib/ai/router.ts</file>
    <file>src/lib/ai/types.ts</file>
  </files_to_modify>
  <dependencies>
    <dependency>TECHNICAL_STANDARDS.md (Complete)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>BaseAIProvider interface definition</criterion>
    <criterion>Claude provider implementation</criterion>
    <criterion>OpenAI fallback provider</criterion>
    <criterion>Automatic fallback on provider failures</criterion>
    <criterion>Rate limiting and quota management</criterion>
    <criterion>Structured response parsing</criterion>
    <criterion>Cost tracking and optimization</criterion>
  </completion_criteria>
  <estimated_hours>10</estimated_hours>
</task>

<task id="BE_2025_09_06_004" status="ready">
  <title>Monitor CRUD API Endpoints</title>
  <assigned_to>unassigned</assigned_to>
  <priority>high</priority>
  <description>Implement RESTful API endpoints for monitor management: create, read, update, delete, and list monitors. Include validation, error handling, user authorization, and proper HTTP status codes.</description>
  <files_to_modify>
    <file>src/routes/api/monitors/+server.ts</file>
    <file>src/routes/api/monitors/[id]/+server.ts</file>
    <file>src/lib/db/monitors.ts</file>
    <file>src/lib/validation/monitors.ts</file>
  </files_to_modify>
  <dependencies>
    <dependency>BE_2025_09_06_001 - Database Schema (blocking)</dependency>
    <dependency>BE_2025_09_06_002 - Authentication (blocking)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>POST /api/monitors - create monitor</criterion>
    <criterion>GET /api/monitors - list user monitors</criterion>
    <criterion>GET /api/monitors/[id] - get monitor details</criterion>
    <criterion>PUT /api/monitors/[id] - update monitor</criterion>
    <criterion>DELETE /api/monitors/[id] - delete monitor</criterion>
    <criterion>Input validation with Zod schemas</criterion>
    <criterion>User authorization checks</criterion>
    <criterion>Proper error handling and responses</criterion>
  </completion_criteria>
  <estimated_hours>6</estimated_hours>
</task>

<task id="BE_2025_09_06_005" status="ready">
  <title>Monitor Evaluation Engine Core</title>
  <assigned_to>unassigned</assigned_to>
  <priority>high</priority>
  <description>Build the core monitor evaluation engine that processes monitors, calls AI providers for evaluation, stores results, and determines trigger conditions. Implement temporal logic separation for current state vs change detection.</description>
  <files_to_modify>
    <file>src/lib/monitors/evaluator.ts</file>
    <file>src/lib/monitors/temporal-logic.ts</file>
    <file>src/lib/db/evaluations.ts</file>
    <file>src/lib/external/data-sources.ts</file>
  </files_to_modify>
  <dependencies>
    <dependency>BE_2025_09_06_003 - AI Provider Layer (blocking)</dependency>
    <dependency>BE_2025_09_06_001 - Database Schema (blocking)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>Monitor evaluation workflow</criterion>
    <criterion>Current state vs change detection logic</criterion>
    <criterion>External data source integration</criterion>
    <criterion>Evaluation result storage</criterion>
    <criterion>Trigger condition detection</criterion>
    <criterion>Error handling and logging</criterion>
    <criterion>Performance metrics collection</criterion>
  </completion_criteria>
  <estimated_hours>12</estimated_hours>
</task>

<task id="BE_2025_09_06_006" status="ready">
  <title>Background Job Scheduling System</title>
  <assigned_to>unassigned</assigned_to>
  <priority>high</priority>
  <description>Implement background job system for scheduled monitor evaluations. Create job queue, worker processes, and scheduling logic supporting different evaluation frequencies (5min, 15min, 1hour, 6hour).</description>
  <files_to_modify>
    <file>src/lib/jobs/scheduler.ts</file>
    <file>src/lib/jobs/worker.ts</file>
    <file>src/lib/jobs/queue.ts</file>
    <file>src/routes/api/jobs/+server.ts</file>
  </files_to_modify>
  <dependencies>
    <dependency>BE_2025_09_06_005 - Monitor Evaluation Engine (blocking)</dependency>
  </dependencies>
  <completion_criteria>
    <criterion>Job scheduling with configurable intervals</criterion>
    <criterion>Background worker process</criterion>
    <criterion>Job queue management</criterion>
    <criterion>Failed job retry logic</criterion>
    <criterion>Job monitoring and status tracking</criterion>
    <criterion>Performance optimization</criterion>
  </completion_criteria>
  <estimated_hours>8</estimated_hours>
</task>

## Task Template
```xml
<task_update>
  <agent_id>agent_XXXXXXXXX_XXXX</agent_id>
  <role>backend_developer</role>
  <task_id>BE_YYYY_MM_DD_###</task_id>
  <title>Task Title</title>
  <status>planning|in_progress|testing|completed|blocked</status>
  <priority>high|medium|low</priority>
  <description>Detailed task description</description>
  <files_modified>
    <file>path/to/file1.ts</file>
    <file>path/to/file2.sql</file>
  </files_modified>
  <dependencies>
    <dependency>Other task or deliverable required</dependency>
  </dependencies>
  <blockers>
    <blocker>Issue preventing progress</blocker>
  </blockers>
  <completion_criteria>
    <criterion>Specific requirement 1</criterion>
    <criterion>Specific requirement 2</criterion>
  </completion_criteria>
  <estimated_hours>X</estimated_hours>
  <actual_hours>Y</actual_hours>
  <timestamp>2025-09-06T02:34:00Z</timestamp>
</task_update>
```

## Coordination Rules

1. **Always check active_work_registry.json before claiming tasks**
2. **Create agent lock files before modifying any code**
3. **Update this file when starting/completing tasks**
4. **Follow backend role dependencies in role_backend_developer.md**
5. **Use isolated git worktrees per AGENT_ISOLATION_PROTOCOL.md**