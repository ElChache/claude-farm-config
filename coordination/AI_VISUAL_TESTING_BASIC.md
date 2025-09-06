# AI Visual Testing - How to Take Photos

## Take Screenshot Command
```javascript
await page.screenshot({ path: `/tmp/screenshot_${agentId}_${Date.now()}.png` });
```

## Setup Requirements
1. Use your agent ID from roles.json (e.g. be_primary_001_a7b9)
2. Screenshots save to /tmp/ directory
3. Include timestamp in filename to avoid conflicts

## When to Take Photos
- After major changes to verify functionality
- Before marking tasks as "done" 
- When you need to show visual proof
- To verify UI components render correctly

## Example Usage
```javascript
// Navigate to page
await page.goto('http://localhost:3000');

// Take screenshot
await page.screenshot({ path: `/tmp/screenshot_${agentId}_${Date.now()}.png` });

// Interact with elements
await page.click('button');
await page.fill('input', 'test data');

// Take another screenshot
await page.screenshot({ path: `/tmp/screenshot_${agentId}_${Date.now()}.png` });
```

DOCUMENT COMPLETE