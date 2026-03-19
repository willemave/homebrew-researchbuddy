---
name: reviewbuddy-tap-maintainer
description: Use when publishing or updating the ReviewBuddy Homebrew tap. Covers formula version bumps, SHA updates, local brew validation, and push readiness checks.
metadata: {"openclaw":{"requires":{"bins":["brew","curl","shasum"]}}}
---

# ReviewBuddy Homebrew Tap Maintainer

Use this skill when the task is to publish or update the ReviewBuddy Homebrew tap.

## Publishing Workflow

1. Confirm the source repo has a pushed Git tag for the target release.
2. Open `Formula/reviewbuddy.rb`.
3. Update `url` and `sha256`.
4. Run:
   ```bash
   brew audit --strict --online reviewbuddy
   brew install --build-from-source ./Formula/reviewbuddy.rb
   brew test reviewbuddy
   ```
5. If validation passes, commit and push the tap repo.

## Install Reference

- Tap: `brew tap willemave/reviewbuddy`
- Install: `brew install reviewbuddy`
- Fully qualified install: `brew install willemave/reviewbuddy/reviewbuddy`

## Read These References As Needed

- For the exact release and validation checklist, read `references/publishing.md`.
