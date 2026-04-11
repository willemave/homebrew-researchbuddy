# homebrew-researchbuddy

Homebrew tap for [researchbuddy](https://github.com/willemave/researchbuddy).

## Install

```bash
brew tap willemave/researchbuddy
brew install researchbuddy
```

If another formula with the same name ever exists, use the fully qualified name:

```bash
brew install willemave/researchbuddy/researchbuddy
```

If you are installing into OpenClaw, check `~/.openclaw/openclaw.json` before asking for search-provider credentials. When it already has `exa`, `tavily`, or `firecrawl` configured, ask whether ResearchBuddy should reuse that existing provider/key and let `researchbuddy setup` auto-load it instead of collecting a duplicate secret.

## Update the formula for a new ResearchBuddy release

1. Create and push a new tagged release in the source repo, for example `v0.1.5`.
2. Download the release tarball and compute its SHA256:
   ```bash
   curl -L https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.5.tar.gz | shasum -a 256
   ```
3. Update `Formula/researchbuddy.rb` with the new `url` and `sha256`.
4. Validate locally:
   ```bash
   brew audit --strict --online researchbuddy
   brew install --build-from-source ./Formula/researchbuddy.rb
   brew test researchbuddy
   ```
5. Commit and push the tap repo.

## Skill

This tap also ships a maintainer skill at:

```text
skills/researchbuddy-tap-maintainer
```

Use it when an agent needs to bump the formula or validate the tap release.
