---
name: researchbuddy-tap-maintainer
description: Use when publishing or updating the ResearchBuddy Homebrew tap. Covers formula version bumps, SHA updates, local brew validation, and push readiness checks.
metadata: {"openclaw":{"requires":{"bins":["brew","curl","shasum"]}}}
---

# ResearchBuddy Homebrew Tap Maintainer

Use this skill when the task is to publish or update the ResearchBuddy Homebrew tap.

## Publishing Workflow

1. Confirm the source repo has a pushed Git tag for the target release.
2. Open `Formula/researchbuddy.rb`.
3. Update `url` and `sha256`.
4. Run:
   ```bash
   brew audit --strict --online researchbuddy
   brew install --build-from-source ./Formula/researchbuddy.rb
   brew test researchbuddy
   ```
5. If validation passes, commit and push the tap repo.

## Install Reference

- Tap: `brew tap willemave/researchbuddy`
- Install: `brew install researchbuddy`
- Fully qualified install: `brew install willemave/researchbuddy/researchbuddy`

## Read These References As Needed

- For the exact release and validation checklist, read `references/publishing.md`.
