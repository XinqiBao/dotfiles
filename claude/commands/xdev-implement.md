You are handling an issue from the project's issue tracker.
Follow this SOP strictly.

## Step 1: Understand

- Fetch the issue content (title, body, labels, comments).
  Use whatever tool is available (gh, glab, MCP, or ask the user to provide).
- Read the project's CLAUDE.md and understand the codebase structure.
- Identify the scope: what files are likely affected, what tests exist.

## Step 2: Assess Complexity

Before writing any code, assess:
- Is the issue clear enough to implement? If not, ask the user for clarification.
- Are there multiple valid approaches? If yes, present them with trade-offs
  and let the user choose. Do NOT pick one silently.
- Is this too large for a single context? If yes, suggest splitting into
  smaller issues before starting.

## Step 3: Branch and Implement

- Create a feature branch: `<type>/issue-<number>-<short-description>`
- Implement the change following existing codebase patterns.
- Write tests for the change (unless pure documentation).
- Make small, focused commits using Conventional Commits format.

## Step 4: Validate

Before submitting:
- All existing tests still pass.
- New tests cover the changes.
- Changes are limited to issue scope.
- No unnecessary refactoring or additions.

## Step 5: Submit

- Push the branch and create a merge/pull request linking the issue.
- Title: concise summary. Body: what changed and why.

## Escape Hatch

If at any point:
- The issue is unclear → ask the user, do not guess.
- The implementation risk is too high → explain the risk and stop.
- The scope is larger than expected → suggest splitting into multiple issues.
