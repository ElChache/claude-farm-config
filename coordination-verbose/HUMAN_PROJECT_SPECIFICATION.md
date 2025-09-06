# Human Project Specification

## Project Vision

**"The Datadog of Real Life"** - A monitoring application that alerts users about real-world conditions and enables automated actions based on those alerts.

## Core Concept

Users create monitors using natural language prompts to track real-world conditions (stock prices, weather, sports events, etc.). When conditions are met or change, the system triggers user-defined actions.

## Target Users

**Release 1.0**: **Individual consumers** - not enterprises or corporations. Think tech-savvy individuals who want to monitor personal interests: stock prices, weather patterns, sports events, gaming updates, etc. The application is designed for personal use cases, not business/corporate monitoring needs.

**Future Releases**: **Enterprise expansion** - corporations might want to use this for business monitoring (market conditions, competitor tracking, industry events). Future considerations include:
- Multi-tenancy architecture for corporate accounts
- Okta authentication and enterprise SSO integration  
- Team-based monitor sharing and collaboration
- Corporate billing and usage management
- Advanced admin controls and audit logging

## Key Features

### Monitor Creation
- Users create monitors with natural language prompts
- AI processes and validates prompts for clarity and feasibility
- Two types of monitor logic:
  - **Current State Monitors**: Track if a condition is currently true/false
  - **Change Monitors**: Detect when something has changed in a specific way

### Monitor States & Logic
- Monitors have **active** or **inactive** states
- **Current State Monitors**: "5 sunny days in a row in Vancouver" - becomes active when condition is met
- **Change Monitors**: "Tesla stock dropped 10% in last hour" - requires extracting the fact ("Tesla stock price") and change condition ("dropped 10%")

### Intelligent State Processing - The Core Innovation

**The Challenge**: Change detection ("Tesla stock dropped 10%") vs state detection ("Tesla stock is below $100") are fundamentally different problems that most systems handle poorly.

**The Solution - Temporal Logic Separation**:

#### Current State Monitors (Simple)
- User prompt: "Tesla stock is below $100"
- **AI classifies prompt type**: "current state" (not historical change)
- AI extracts fact: "Tesla stock price"  
- AI evaluates current state: true/false
- Monitor becomes active/inactive based on current evaluation

#### Historical Change Monitors (Complex - The Innovation)
User prompts requiring change detection get decomposed:

**Example 1**: "Tesla stock dropped 10% in last hour"
- **AI classifies prompt type**: "historical change" 
- **Fact prompt**: "Tesla stock price"
- **Change condition**: current_price < (previous_price × 0.9) AND time_diff = 1 hour
- **System provides**: current_value AND previous_value AND change_condition to AI for final evaluation

**Example 2**: "Lamine Yamal becomes La Liga maximum scorer (pichichi)"  
- **AI classifies prompt type**: "historical change"
- **Fact prompt**: "La Liga maximum scorer"
- **Change condition**: current_scorer = "Lamine Yamal" AND previous_scorer ≠ "Lamine Yamal"
- **System provides**: current_value AND previous_value AND change_condition to AI for final evaluation

**Example 3**: "Vancouver drops from top 5 most livable cities"
- **AI classifies prompt type**: "historical change"
- **Fact prompt**: "Top 5 most livable cities in the world"
- **Change condition**: "Vancouver" NOT IN current_list AND "Vancouver" WAS IN previous_list
- **System provides**: current_value AND previous_value AND change_condition to AI for final evaluation

#### The Architecture Genius - Historical Value Persistence

**The Key Innovation**: Our system saves ALL historical fact values with timestamps for every monitor evaluation.

**AI Evaluation Process**: The system provides the AI with three pieces:
1. **Current value** (from latest fact extraction)
2. **Previous value** (from our historical storage) 
3. **Change condition** (the equation/rule to evaluate)

The AI simply evaluates: "Does this change condition = true given these values?" Like plugging values into an equation.

1. **AI Handles Present**: Extracts facts and evaluates current state only
2. **System Handles History**: **Stores every single fact value with timestamps** - this is the foundation that makes everything work
3. **AI Handles Comparison**: Given current + previous values, determines if change condition is met
4. **Clean Separation**: No AI memory required, reliable temporal logic, scalable to complex changes

**Why Historical Storage is Critical**:
- We never rely on AI to "remember" previous values
- Every monitor evaluation creates a permanent historical record
- Change detection is always based on our reliable stored data, not AI memory
- System can analyze trends over any time period
- Enables complex temporal queries without AI consistency issues

This approach solves the classic "temporal AI consistency problem" by making AI stateless while keeping the system stateful with comprehensive historical data.

### Actions & Triggers
- Users create actions through application UI (not natural language)
- **Release 1.0 Action**: Send rich email notifications
- **Future Actions**: Could include purchasing products, API calls, etc.
- Triggers execute actions when monitor state changes (active ↔ inactive)
- Actions can be configured to trigger once or repeatedly

### Monitor Management & Visualization
- Full CRUD operations: create, edit, delete monitors
- View monitor history and state change logs
- Monitor dashboard showing current states and recent activity
- Action and trigger management interface

**Visual Data Representation**:
- **Current State Monitors**: Display as **card values** showing the current fact value and active/inactive status
  - Example: "Tesla Stock: $247.50" with green/red indicator for active/inactive state
  - Clear, at-a-glance status with current value prominently displayed
- **Historical Change Monitors**: Display as **line charts or bar charts** showing value changes over time
  - Example: Tesla stock price line chart with markers showing when change conditions were triggered
  - Visual trend analysis to help users understand patterns and changes
  - Historical data points with timestamps and state change indicators
- **Monitor Cards**: Compact overview cards for dashboard with key metrics and visual indicators
- **Detailed Views**: Expandable detailed views with full historical data and charts

## Technical Requirements

### Authentication & User Management
- Username/password authentication with latest security standards
- Google OAuth2 integration
- **Release 1.0 Access**: Hard-coded email whitelist for limited beta users
- **User Account Management**:
  - Password change functionality with secure validation
  - Account settings and profile management
  - Session management and secure logout
  - Password reset via email with secure tokens
  - Two-factor authentication considerations for future releases

### AI Integration
- **Primary AI**: Claude for fact extraction and state analysis
- **AI Provider Abstraction**: Build robust abstraction layer to easily swap between Claude and ChatGPT based on performance/availability
- **Provider Flexibility**: System must be ready to switch AI providers without code changes to core logic
- AI determines optimal evaluation frequency per monitor type (stocks: hourly, weather: daily)
- AI searches for real-world data from available sources
- AI handles fact value comparison and change detection logic

### Data & Performance
- Historical state logging for all monitors
- Rate limiting and security controls
- No monitor limits per user (within reasonable rate limits)
- Top-tier security implementation required

### Email System
- Rich content email notifications
- Professional email templates and formatting
- Reliable delivery system

### Data Privacy & Security
- User data encryption at rest and in transit
- GDPR compliance considerations for personal data
- Secure handling of monitor queries and historical data
- No sharing of user monitoring patterns or data with third parties
- Audit logging for data access and modifications

## Architecture Principles

### Separation of Concerns
1. **AI handles "right now" logic**: Current fact extraction and state evaluation
2. **System handles "over time" logic**: Historical comparison and change detection
3. **Clean separation**: Fact extraction → Historical comparison → Change analysis → Action triggering

### Reliability
- All state changes logged with timestamps
- No reliance on AI for historical data management
- Robust error handling and fallback mechanisms

### Technology Requirements & Optimization

**Required Technology Stack**:
- **Frontend**: SvelteKit with TypeScript
- **Deployment**: Vercel
- **Package Manager**: pnpm
- **Language**: TypeScript throughout

**Technology Optimization**: For all other components, engineers should choose the most optimal technology. Engineers must raise blockers when better technology solutions exist.

**Priority: Use free/open-source solutions first** - PostgreSQL, MongoDB, Redis, Node.js, etc. Only escalate when paid services provide significant advantages that justify the cost.

**Examples of PAID technology decisions requiring escalation**:
- If DynamoDB is superior to PostgreSQL/MongoDB for historical data storage (paid AWS service)
- If specific cloud services optimize AI provider integration (paid cloud resources)
- If specialized time-series databases like InfluxDB Cloud are needed (paid service)
- If premium deployment platforms offer significant advantages over Vercel free tier

**Escalation Process**: Technical blockers requiring technology changes should flow through BLOCKERS.md → System Architect → Product Owner → HUMAN_INTERVENTION_REQUIRED.md for final technology procurement/setup decisions.

## Success Criteria

- Users can create monitors with natural language that work reliably
- System accurately detects both current states and changes over time
- Email notifications are timely and contain rich, useful information
- Monitor management interface is intuitive and comprehensive
- System handles concurrent users without performance degradation

## Release 1.0 Scope

### Core Features for Release 1.0
- **Monitor Management**: Full CRUD operations - create, read, update, delete monitors with natural language prompt input and AI classification (current state vs historical change)
- **Actions & Triggers Management**: Complete CRUD for actions and triggers - users can create, edit, and delete email actions and configure when they trigger
- **Two Monitor Types**: Current state monitors (card displays) and historical change monitors (chart displays) 
- **AI Integration**: Claude-powered fact extraction, state evaluation, and change detection with provider abstraction layer
- **Historical Data**: Complete logging of all fact values with timestamps for reliable temporal logic
- **Email Actions**: Rich content email notifications as the primary action type
- **User Management**: Username/password + Google OAuth authentication with account management features
- **Monitor Dashboard**: Visual interface with cards, charts, and detailed historical views
- **Responsive Design**: Full mobile and desktop support with accessibility compliance

### User Experience Requirements
- **Intuitive Navigation**: Smooth sail through the application - users should effortlessly move between monitors, actions, and settings
- **Clear Visual Hierarchy**: Monitor cards and charts should be immediately understandable with obvious status indicators
- **Responsive Interactions**: Fast, snappy UI responses with proper loading states and error handling
- **Onboarding Flow**: New users should understand how to create their first monitor within minutes
- **Accessibility Standards**: Full WCAG compliance for screen readers and keyboard navigation
- **Mobile-First Design**: Seamless experience across all devices with touch-optimized interactions

### Portal & Domain Architecture
- **Portal Website**: Separate marketing/landing site for authentication and app access
- **Subdomain Structure**: Application hosted at `app.domain.com` (preferred over `domain.com/app`)
- **Release 1.0 Domain**: Vercel auto-assigned domain (acceptable for beta testing)
- **Future Domain Strategy**: Custom domain migration planned for public release
- **Authentication Flow**: Portal handles login/signup, then redirects to main application
- **Brand Consistency**: Portal and application maintain consistent visual identity

### Technical Implementation
- **Frontend**: SvelteKit with TypeScript, deployed on Vercel
- **Backend**: Node.js with TypeScript, optimized for monitor evaluation processing
- **Database**: PostgreSQL or MongoDB (whichever optimizes historical data storage)
- **Authentication**: Secure session management with password reset and account controls
- **Security**: Data encryption, GDPR compliance, audit logging

### User Access & Testing
- **Beta User Access**: Hard-coded email whitelist (50-100 users initially)
- **No Usage Limits**: Users can create unlimited monitors (within rate limiting)
- **Testing Focus**: Validate core temporal logic, user experience, and email delivery systems

### Future Expansion (Post Release 1.0)
- **Additional Actions**: Purchase automation, API integrations, webhooks, SMS notifications
- **Enterprise Features**: Multi-tenancy, Okta SSO, team collaboration, corporate billing
- **Public Release**: General availability with monetization and subscription models
- **Advanced Monitoring**: Complex multi-condition monitors, trend analysis, predictive alerts

### Scalability Expectations for Release 1.0
**Current Requirements** (Beta Users):
- Support 50-100 beta users comfortably
- Handle 1,000+ monitors across all users
- Process monitor evaluations efficiently without performance degradation
- Reasonable response times for dashboard and monitor management

**Future Scalability Readiness**:
- Architecture must be designed to scale to thousands of users
- Database design should handle millions of historical data points
- AI integration should support high-volume concurrent requests
- Consider horizontal scaling patterns (load balancing, database sharding, caching layers)
- Build with microservices mindset even if starting as monolith

**Performance Targets**:
- Monitor evaluation: Complete within 30 seconds per monitor
- Dashboard load: Sub-2 second response times
- Historical data queries: Efficient even with large datasets

---

*This specification captures the core vision for an intelligent real-world monitoring system that combines natural language processing with robust state management and automated actions.*