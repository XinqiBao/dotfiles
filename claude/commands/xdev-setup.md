Analyze the current project and generate a health report. Then guide
the user through setting up CLAUDE.md if one doesn't exist.

## Step 1: Project Analysis

Scan the project root and report findings for each quality dimension.
Do not assume any specific language or toolchain.

### Build System
Detect build files: CMakeLists.txt, Makefile, meson.build, package.json,
pyproject.toml, setup.py, Cargo.toml, go.mod, build.gradle, pom.xml,
or other build configuration.
Report what was found, or note "no build system detected".

### Testing
Detect test directories: tests/, test/, __tests__/, spec/, or test
files matching common patterns (*_test.*, test_*.*, *.spec.*, *_spec.*).
Detect test runner config: pytest.ini, jest.config.*, .mocharc.*,
CTestTestfile.cmake, Catch2/GoogleTest headers, etc.
Report what was found.

### Code Quality Tools
Detect formatter/linter config: .clang-format, .clang-tidy, .eslintrc*,
.prettierrc*, pyproject.toml [tool.ruff/black/flake8], rustfmt.toml,
.editorconfig, .golangci.yml, or similar.
Detect git hooks: .pre-commit-config.yaml, .husky/, .githooks/.
Report what was found.

### CI/CD
Detect: .github/workflows/, .gitlab-ci.yml, Jenkinsfile, .circleci/,
.travis.yml, bitbucket-pipelines.yml, or similar.
Report what was found.

### Documentation
Check: README.md and CLAUDE.md existence. If they exist, note whether
they have meaningful content beyond just a title.

## Step 2: Report

Present findings as a concise checklist:

```
Project Health Report: <project-name>
  Build system:    ✓ CMake (CMakeLists.txt)
  Tests:           ✓ tests/ directory, GoogleTest
  Code quality:    ✓ .clang-format, .clang-tidy, pre-commit
  CI/CD:           ✗ No CI configuration found
  README:          ✓ Exists with content
  CLAUDE.md:       ✗ Missing
```

For each ✗ item, provide a brief, actionable suggestion.
Do NOT mandate specific tools — suggest based on what fits the project.

## Step 3: CLAUDE.md Creation (if missing or inadequate)

If CLAUDE.md doesn't exist or is just a placeholder, guide the user:

1. Ask about the project's purpose (one sentence).
2. Document detected build/test commands.
3. Ask about key code conventions or architectural constraints.
4. Generate a minimal CLAUDE.md (under 50 lines) following this structure:

```markdown
# <Project Name>

<One-sentence project description.>

## Quick Reference

\```bash
# Build
<build command>

# Test
<test command>
\```

## Code Conventions

- <Convention 1>
- <Convention 2>

## Constraints

- <Things Claude should NOT do>
- <Protected files/directories>
- <Dependency rules>
```

Do NOT over-generate. A 20-line CLAUDE.md with accurate info is better
than a 100-line one with guesses.

## Step 4: Hooks Suggestion (optional)

If a code formatter is detected, suggest a PostToolUse hook configuration
that auto-formats after edits. Present the suggestion and let the user
decide whether to add it to `.claude/settings.local.json`.
