# Monitors! - Project Specification

## Project Overview

**Monitors!** is an AI-powered monitoring application that enables users to create natural language monitors for tracking facts, conditions, and changes in real-time. The system leverages advanced AI to understand user intents, validate prompts, and evaluate complex conditions without requiring users to write code or configure complex rules.

## Core Concept

Users can create monitors using simple natural language like:
- "Tesla stock is under $500"
- "It's going to rain in San Francisco tomorrow"
- "Bitcoin has increased by more than 10% in the last week"
- "My website is responding slower than 2 seconds"

The AI system intelligently:
- Validates and improves user prompts
- Classifies prompts into fact monitoring vs change detection
- Extracts key information and evaluation logic
- Performs regular evaluations and sends notifications

## Target Users & Use Cases

### Primary User Profiles

#### Individual Investors & Traders
- **Needs**: Track stock prices, market movements, financial indicators
- **Goals**: Get notified when investment conditions change
- **Examples**: "Apple stock drops below $150", "S&P 500 gains more than 2% today"

#### Small Business Owners
- **Needs**: Monitor business metrics, website performance, market conditions
- **Goals**: Stay informed about business-critical changes
- **Examples**: "Website downtime", "Competitor pricing changes", "Local weather affecting business"

#### Tech Enthusiasts & Professionals
- **Needs**: Monitor system status, API availability, technology news
- **Goals**: Stay updated on technical developments and system health
- **Examples**: "GitHub API is down", "New iPhone announcement", "AWS us-east-1 issues"

#### General Consumers
- **Needs**: Track personal interests, local events, lifestyle factors
- **Goals**: Stay informed about topics that matter to them
- **Examples**: "Favorite restaurant has new menu", "Concert tickets go on sale", "Gas prices in my area"

### Primary Use Cases

1. **Financial Monitoring**: Stock prices, market indices, cryptocurrency values, economic indicators
2. **Business Intelligence**: Website performance, competitor analysis, market trends
3. **Personal Interests**: News, events, product availability, local information
4. **System Monitoring**: API status, service availability, performance metrics
5. **Environmental Tracking**: Weather, air quality, natural events

## Core Features & Functionality

### 1. Intelligent Monitor Creation

#### Natural Language Input Processing
- Users enter monitors in plain English
- AI validates prompt clarity and measurability
- System provides real-time feedback and improvement suggestions
- Examples and templates help users create effective monitors

#### Smart Prompt Enhancement
- AI identifies ambiguous or incomplete prompts
- Suggests specific improvements: "Tesla stock" → "Tesla stock price (TSLA)"
- Provides context-aware examples for similar monitors
- Guides users toward measurable, actionable conditions

#### Monitor Classification
- **Fact Monitors**: Track current state ("Tesla stock is under $500")
- **Change Monitors**: Detect changes over time ("Bitcoin increased 10% this week")
- Automatic classification based on prompt analysis
- Different evaluation strategies for each type

### 2. AI-Powered Evaluation Engine

#### Fact Evaluation
- AI extracts core facts from natural language prompts
- Intelligent web research and data gathering
- Real-time evaluation of current conditions
- Handles complex queries requiring reasoning and context

#### Change Detection
- AI-driven historical comparison and analysis
- Sophisticated pattern recognition for trend detection
- Flexible time window analysis (hours, days, weeks, months)
- Complex change logic: percentages, absolute values, directional changes

#### Intelligent Caching & Optimization
- Smart fact deduplication across users
- Efficient caching of common queries
- Cost-optimized AI usage through intelligent batching
- Performance optimization for high-frequency evaluations

### 3. User Dashboard & Management

#### Monitor Dashboard
- Clean, organized view of all user monitors
- Real-time status indicators (active, triggered, error, etc.)
- Sorting and filtering by status, category, creation date
- Bulk operations for managing multiple monitors

#### Historical Analysis
- Complete evaluation history for each monitor
- Visual trends and pattern analysis
- Detailed logs of AI reasoning and decision-making
- Performance metrics and accuracy tracking

#### Monitor Management
- Easy editing and updating of existing monitors
- Pause/resume functionality for temporary disable
- Monitor categorization and organization
- Sharing and collaboration features

### 4. Notification & Alert System

#### Multi-Channel Notifications
- Email notifications with detailed context
- In-app notifications and alerts
- Future: SMS, Slack, Discord integrations
- Customizable notification preferences per monitor

#### Smart Notification Logic
- Intelligent alert frequency management
- Avoid notification spam for repeated conditions
- Context-aware notification content
- Summary digests for multiple triggered monitors

### 5. Advanced AI Features

#### Prompt Improvement Assistant
- Real-time suggestions as users type
- AI-powered prompt optimization recommendations
- Learning from successful monitor patterns
- Context-aware examples and templates

#### Uncertainty Handling
- Graceful handling of ambiguous or unclear conditions
- Confidence scoring for AI evaluations
- User feedback integration for continuous improvement
- Fallback strategies for uncertain evaluations

#### Cost Optimization Intelligence
- Automatic optimization of AI token usage
- Smart caching and deduplication strategies
- Predictive cost management and budgeting
- Transparent cost reporting for users

## Technical Requirements

### Architecture Principles

#### AI-First Design
- **All complex reasoning must be AI-driven, not algorithmic**
- No hardcoded logic for change detection or condition evaluation
- AI handles interpretation, comparison, and decision-making
- Flexible, learning-based approach to new monitor types

#### Scalability Requirements
- Support thousands of concurrent users
- Handle millions of monitor evaluations efficiently
- Horizontal scaling for AI processing workloads
- Optimized database design for high-volume operations

#### Reliability Standards
- 99.9% system uptime
- Sub-2-second response times for standard operations
- Graceful degradation during AI provider outages
- Comprehensive error handling and recovery mechanisms

### Core System Components

#### Database Schema Design

##### Users Table
- Standard authentication and profile management
- User preferences and notification settings
- Usage tracking and billing information
- Account limits and subscription tiers

##### Monitors Table
- User-created monitors with original prompts
- AI-extracted metadata and classification
- Evaluation frequency and scheduling information
- Status tracking and configuration options

##### Facts Table
- Cached fact values for efficiency and deduplication
- Shared across users for common queries
- TTL-based cache invalidation strategies
- Optimization for frequently accessed data

##### Evaluations Table
- Complete history of all monitor evaluations
- AI reasoning and confidence scoring
- Performance metrics and timing data
- Error logs and debugging information

##### Notifications Table
- Notification history and delivery tracking
- User preferences and channel configurations
- Rate limiting and frequency management
- Template and content management

#### AI Provider Integration

##### Claude Integration (Primary)
- Advanced reasoning capabilities for complex monitors
- Excellent natural language understanding
- Cost-effective for high-volume processing
- Superior handling of ambiguous queries

##### OpenAI Integration (Fallback)
- GPT-4 for when Claude is unavailable
- Different prompt strategies optimized for each provider
- Seamless fallback with quality preservation
- Cost comparison and optimization

##### Provider Abstraction Layer
- Unified interface for all AI providers
- Intelligent routing and load balancing
- Response format normalization
- Error handling and retry mechanisms

#### Background Processing System

##### Monitor Evaluation Scheduling
- Flexible scheduling based on monitor types
- Priority queuing for time-sensitive monitors
- Batch processing for efficiency
- Real-time processing for urgent conditions

##### AI Processing Pipeline
- Asynchronous processing for scalability
- Intelligent batching and optimization
- Error handling and retry logic
- Performance monitoring and analytics

##### Notification Delivery
- Multi-channel notification processing
- Rate limiting and user preferences
- Delivery confirmation and tracking
- Failed delivery retry mechanisms

### Authentication & Security

#### User Authentication
- Email/password authentication with secure hashing
- Google OAuth2 integration for easy onboarding
- Session management with secure tokens
- Password reset and account recovery

#### Data Security
- User data isolation and privacy protection
- Encrypted storage of sensitive information
- Secure API endpoints with proper validation
- Rate limiting and abuse prevention

#### AI Security
- Input sanitization and validation
- Prevention of prompt injection attacks
- Secure handling of AI provider credentials
- Cost monitoring and usage limits

## User Experience Requirements

### Onboarding Experience
- Clear explanation of monitor types and capabilities
- Interactive tutorial with real monitor examples
- Guided creation of first monitor with AI assistance
- Progressive disclosure of advanced features

### Core User Workflows

#### Monitor Creation Flow
1. User enters natural language prompt
2. AI provides real-time validation and suggestions
3. User refines prompt with AI assistance
4. AI classifies monitor type and extracts metadata
5. User confirms and activates monitor

#### Dashboard Experience
1. Clean overview of all monitors with status indicators
2. Quick access to create new monitors
3. Filtering and sorting options for organization
4. Detailed view with history and performance metrics

#### Notification Management
1. Customizable notification preferences per monitor
2. Multiple delivery channels and formatting options
3. Notification history and tracking
4. Bulk management and organization tools

### Mobile Responsiveness
- Fully responsive design for all screen sizes
- Touch-optimized interactions and navigation
- Progressive web app capabilities
- Offline functionality for viewing monitor status

### Accessibility Standards
- WCAG 2.1 AA compliance for all interfaces
- Keyboard navigation and screen reader support
- High contrast mode and reduced motion options
- Clear visual hierarchy and intuitive navigation

## Success Metrics & KPIs

### User Engagement
- Monitor creation rate and success rate
- Daily/weekly active users and retention
- Average number of monitors per user
- User session duration and interaction depth

### System Performance
- Monitor evaluation accuracy and consistency
- AI processing time and cost efficiency
- System uptime and reliability metrics
- User satisfaction scores and feedback

### Business Metrics
- User acquisition and conversion rates
- Subscription revenue and growth
- Cost per evaluation and unit economics
- Feature adoption and usage patterns

## Competitive Landscape & Differentiation

### Key Differentiators
1. **Natural Language Interface**: No complex configuration or rule setup
2. **AI-Powered Intelligence**: Advanced reasoning without hardcoded logic
3. **Universal Monitoring**: Support for any type of condition or change
4. **Cost-Effective AI**: Optimized token usage and intelligent caching
5. **User-Friendly Design**: Intuitive interface for non-technical users

### Competitive Advantages
- Sophisticated AI understanding of user intent
- Flexible monitoring without technical constraints
- Continuous learning and improvement capabilities
- Seamless integration of multiple data sources
- Proactive user assistance and optimization

## Development Priorities & Phases

### Phase 1: Core Foundation (MVP)
- User authentication and basic account management
- Monitor creation with AI validation and improvement
- Basic fact and change detection capabilities
- Simple dashboard with monitor status and history
- Email notifications for triggered monitors

### Phase 2: Enhanced Intelligence
- Advanced AI reasoning and complex condition handling
- Historical analysis and trend detection
- Improved prompt suggestions and templates
- Performance optimization and cost reduction
- Enhanced dashboard with analytics and insights

### Phase 3: Scale & Polish
- Multi-channel notifications (SMS, Slack, etc.)
- Advanced user management and collaboration features
- Mobile app development
- API access for power users
- Enterprise features and scaling

### Phase 4: Advanced Features
- Machine learning for personalized suggestions
- Integration marketplace for data sources
- Advanced analytics and business intelligence
- White-label and API platform offerings
- Global expansion and localization

## Technical Integration Notes

### AI Provider Requirements
- Primary: Claude 3.5 Sonnet or latest available model
- Fallback: GPT-4 or current best available OpenAI model
- Response format: Structured JSON with confidence scores
- Error handling: Graceful degradation and user-friendly messages

### External Data Sources
- Financial APIs for stock and market data
- Weather services for environmental monitoring
- News APIs for event and announcement tracking
- Web scraping capabilities for custom data sources
- Social media APIs for sentiment and trend analysis

### Deployment Requirements
- Vercel deployment with serverless functions
- PostgreSQL database with proper indexing and optimization
- CDN for static assets and global performance
- Monitoring and logging for system observability
- Automated backup and disaster recovery

This specification serves as the definitive guide for all development teams working on the Monitors! project. All agents should reference this document for project-specific requirements, examples, and implementation details while following their generic role guidelines.