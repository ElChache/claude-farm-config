# Code Review Checklist

## Functionality Verification

### Core Functionality
- [ ] **Code actually runs without errors** - Pull PR, install dependencies, start application
- [ ] **Features work as specified in requirements** - Test the exact functionality described in task/ticket
- [ ] **APIs return correct responses and handle errors** - Test happy path and error cases
- [ ] **UI components render correctly and function properly** - Visual and interactive testing
- [ ] **Database operations complete successfully** - Verify CRUD operations, transactions, migrations

### Error Handling & Edge Cases
- [ ] **Invalid input handling** - Test with malformed, missing, or excessive input
- [ ] **Network failure scenarios** - Test API timeouts, connection issues, offline states
- [ ] **Authentication/authorization failures** - Test unauthorized access, expired tokens
- [ ] **Resource limitations** - Test with large datasets, memory constraints, rate limits
- [ ] **Concurrent operations** - Test race conditions, simultaneous access

### Integration Testing
- [ ] **End-to-end user workflows** - Complete user journeys work correctly
- [ ] **Third-party service integration** - External APIs, databases, services function
- [ ] **Cross-browser compatibility** - Major browsers render and function correctly
- [ ] **Mobile responsiveness** - Application works on different screen sizes

## Code Quality Checks

### TypeScript & Compilation
- [ ] **TypeScript compilation without errors or warnings** - `pnpm run type-check` passes
- [ ] **Strict type checking compliance** - No `any` types, proper interfaces/types
- [ ] **Import/export statements correct** - No unused imports, proper module resolution
- [ ] **Type definitions complete** - Complex objects have proper type definitions

### Testing Requirements
- [ ] **All tests pass** - Unit, integration, and e2e tests execute successfully
- [ ] **Code coverage meets minimum requirements** - At least 80% coverage for new code
- [ ] **Test quality and relevance** - Tests actually verify functionality, not just syntax
- [ ] **Edge cases tested** - Tests cover error conditions and boundary scenarios

### Code Style & Standards
- [ ] **Linting passes without warnings** - ESLint rules followed consistently
- [ ] **Code formatting consistent** - Prettier applied, consistent style throughout
- [ ] **Naming conventions followed** - camelCase variables, PascalCase components, descriptive names
- [ ] **No console.log or debugging code** - Development debugging artifacts removed

### Security & Best Practices
- [ ] **Input validation and sanitization** - User input properly validated using Zod or similar
- [ ] **SQL injection prevention** - Parameterized queries, ORM usage
- [ ] **XSS protection** - HTML output escaped, CSP headers if applicable
- [ ] **Authentication/authorization proper** - JWT handling, role-based access control
- [ ] **Sensitive data protection** - No hardcoded secrets, environment variables used

## Architecture Compliance

### SvelteKit Standards
- [ ] **Component organization follows project structure** - Components in proper directories
- [ ] **State management patterns consistent** - Appropriate use of stores vs local state
- [ ] **Route organization logical** - Feature-based routing, proper load functions
- [ ] **Performance optimizations applied** - Lazy loading, image optimization where needed

### Database Interaction Standards
- [ ] **Query optimization applied** - Efficient queries, proper indexing considered
- [ ] **Transaction handling correct** - Atomic operations, rollback on errors
- [ ] **Connection management proper** - Connection pooling, resource cleanup
- [ ] **Migration scripts valid** - Schema changes properly versioned and tested

### API Design Compliance
- [ ] **RESTful principles followed** - Consistent URL patterns, HTTP methods
- [ ] **Standardized response format** - Success/error responses follow project standards
- [ ] **Error handling comprehensive** - Proper status codes, descriptive error messages
- [ ] **Rate limiting considerations** - API protection mechanisms in place

### AI Integration Standards (if applicable)
- [ ] **Provider abstraction maintained** - Unified interface for AI services
- [ ] **Cost optimization implemented** - Token usage efficient, fallback strategies
- [ ] **Error handling robust** - Graceful degradation when AI services fail
- [ ] **Response validation** - AI responses parsed and validated properly

## Documentation & Maintainability

### Code Documentation
- [ ] **JSDoc comments for public functions** - APIs documented with parameters and returns
- [ ] **Complex logic explained** - Non-obvious code has explanatory comments
- [ ] **README updates** - New features documented in relevant README files
- [ ] **API documentation current** - Swagger/OpenAPI specs updated if applicable

### Change Documentation
- [ ] **Git commit messages descriptive** - Clear description of what and why
- [ ] **Pull request description complete** - Summary, testing notes, breaking changes
- [ ] **Migration notes included** - Database or breaking changes documented
- [ ] **Environment variable changes** - New .env requirements documented

## Performance & Scalability

### Performance Benchmarks
- [ ] **Page load times acceptable** - Under 3 seconds for initial load
- [ ] **API response times reasonable** - Under 200ms for simple queries
- [ ] **Database query performance** - No N+1 queries, proper indexing
- [ ] **Bundle size impact minimal** - New dependencies justified, tree-shaking applied

### Resource Management
- [ ] **Memory usage reasonable** - No obvious memory leaks or excessive usage
- [ ] **Network requests optimized** - Batching, caching, compression where appropriate
- [ ] **Database connections managed** - Proper connection pooling and cleanup
- [ ] **Error logging appropriate** - Sufficient for debugging, not excessive

## AI Visual Testing Integration

### Screenshot-Based Validation
- [ ] **UI components visually correct** - Screenshots verify proper rendering
- [ ] **Responsive design validated** - Mobile and desktop layouts function correctly  
- [ ] **Interactive elements functional** - Buttons, forms, navigation work as expected
- [ ] **Visual regression prevented** - No unintended UI changes introduced

### Testing Setup Compliance
- [ ] **Playwright configuration correct** - Screenshots saved to agent-specific paths
- [ ] **Agent isolation maintained** - Tests run against agent's unique environment
- [ ] **Screenshot paths follow naming convention** - `/tmp/screenshot_${agentId}_${timestamp}.png`

## Deployment Readiness

### Build Process
- [ ] **Application builds successfully** - `pnpm run build` completes without errors
- [ ] **Environment configuration correct** - Production settings applied appropriately
- [ ] **Asset optimization applied** - Images, CSS, JS minified and optimized
- [ ] **Type checking passes in CI** - Build pipeline validates TypeScript

### Production Considerations
- [ ] **Environment variables documented** - Required .env variables listed and described
- [ ] **Database migrations tested** - Schema changes verified on staging data
- [ ] **Third-party service configuration** - External integrations configured for production
- [ ] **Monitoring and logging prepared** - Error tracking and performance monitoring in place

## Final Verification

### Manual Testing Checklist
- [ ] **Pull request locally and test manually** - Actually use the feature end-to-end
- [ ] **Test on different devices/browsers** - Cross-platform compatibility verified
- [ ] **Test with realistic data** - Not just "hello world" test cases
- [ ] **Test error scenarios** - Verify graceful handling of failures

### Team Coordination
- [ ] **Breaking changes communicated** - Other developers aware of changes that affect them
- [ ] **Dependencies updated safely** - Package updates tested and documented
- [ ] **Configuration changes documented** - Infrastructure or environment changes noted
- [ ] **Rollback plan considered** - Strategy for reverting changes if needed

## Review Decision Matrix

### Approve ✅
- All critical items checked
- Minor issues can be addressed in follow-up
- Feature works as specified
- Code quality meets standards

### Request Changes ❌
- Critical functionality doesn't work
- Major code quality issues
- Security vulnerabilities present
- Architecture compliance failures

### Conditional Approval ⚠️
- Minor improvements needed
- Documentation gaps
- Non-critical test failures
- Performance concerns that don't block release

---

## Quick Reference Commands

```bash
# Local testing workflow
git pull origin [branch-name]
nvm use
pnpm install
pnpm run type-check
pnpm run lint
pnpm run test
pnpm run build
pnpm run dev

# Manual testing
curl -X GET http://localhost:5173/api/health
# Test specific endpoints based on changes

# Visual testing (when applicable)
pnpm run test:visual
# Check screenshot outputs in /tmp/screenshot_*
```

---

## Lead Developer Authority & Reality Checking 👨‍💻

### CRITICAL: Over-Optimism Detection
**AI developers frequently exhibit over-enthusiastic behavior.** As Lead Developer, I will immediately challenge:

- **"ENORMOUS SUCCESS!!!"** - Require specific evidence
- **"BEYOND PRODUCTION GRADE!!!"** - Test all claims personally  
- **"WORKING PERFECTLY"** - Verify with edge cases and error scenarios
- **"FULLY IMPLEMENTED"** - Check for missing pieces and shortcuts

### Reality Check Protocol
1. **Pull the branch myself** - No exceptions, always test locally
2. **Test claimed functionality** - Every feature must work as demonstrated
3. **Challenge vague assertions** - Require specific evidence and proof
4. **Test edge cases** - Find the scenarios they didn't test
5. **Verify error handling** - Break it deliberately to see how it fails

### Review Authority
**ONLY I can approve work as complete.** Developers cannot mark their own tasks as "done" until:
- [ ] **I personally verify functionality works**
- [ ] **I confirm code quality standards are met**
- [ ] **I validate performance requirements**
- [ ] **I approve integration with existing codebase**

### Rejection Criteria (AUTOMATIC)
Work will be **immediately rejected** for:
- **Non-functional code** - Claims that don't match reality
- **Missing error handling** - Happy path only implementations
- **Type safety violations** - Ignoring TypeScript errors or using `any`
- **Performance failures** - Not meeting response time requirements
- **Security vulnerabilities** - Unvalidated inputs or exposed secrets

### Approval Process
**Tasks are ONLY complete when I add:**
```
Lead Developer Review: PASSED
Reviewer: ld_claude_002_w9k5  
Date: [Review Date]
Verified: [Specific functionality tested]
```

**NO exceptions. NO self-approval. NO "looks good" without testing.**

---

**Lead Developer Standards**: ld_claude_002_w9k5  
**Authority Level**: ABSOLUTE - Final decision on all technical matters  
**Review Philosophy**: Trust but VERIFY - Every claim will be tested  
**Date**: 2025-09-06T12:50:00Z

This checklist ensures production-ready code. All items are mandatory for approval.

DOCUMENT COMPLETE - LEAD DEVELOPER APPROVED