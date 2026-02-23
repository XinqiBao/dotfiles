Help the user draft a well-structured issue for their project's
issue tracker.

## Process

1. Ask the user to describe what they want in their own words.
2. Ask clarifying questions (one at a time) to understand:
   - What is the problem or desired outcome?
   - What is the current behavior vs expected behavior?
   - Are there constraints or preferences?
3. Draft a structured issue with:
   - Title: `type(scope): concise description`
   - Body:
     - **Context**: why this is needed (1-2 sentences)
     - **Goal**: what should change (concrete, testable)
     - **Acceptance criteria**: how to verify it's done
     - **Constraints** (if any): what NOT to do, what to preserve
4. Present the draft to the user for review.
5. If the user approves, submit using whatever tool is available
   (gh, glab, MCP), or output the formatted text for manual submission.

## Principles

- Intent-driven: describe WHAT and WHY, not HOW to implement.
- Give implementation space: do not over-specify the approach.
- One issue = one change. If the idea is too big, suggest splitting
  into multiple issues.
- Include acceptance criteria so the implementer knows when it's done.
