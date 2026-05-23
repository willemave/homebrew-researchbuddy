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

If you are installing into OpenClaw, check `~/.openclaw/openclaw.json` before asking for search-provider credentials. When it already has `exa`, `tavily`, or `firecrawl` configured under `plugins.entries.<provider>.config.webSearch.apiKey` or the legacy `tools.web.search` paths, ask whether ResearchBuddy should reuse that existing provider/key and let `researchbuddy doctor --fix` auto-load it without copying credentials.

## Update the formula for a new ResearchBuddy release

1. Create and push a new tagged release in the source repo, for example `v0.1.7`.
2. Regenerate `constraints.txt` from the source lockfile:
   ```bash
   uv export --format requirements-txt --no-hashes --no-dev --no-emit-project -o constraints.txt
   ```
3. Download the release tarball and compute its SHA256:
   ```bash
   curl -L https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.7.tar.gz | shasum -a 256
   ```
4. Update `Formula/researchbuddy.rb` with the new `url` and `sha256`.
5. Validate locally:
   ```bash
   brew audit --strict --online researchbuddy
   brew install --build-from-source ./Formula/researchbuddy.rb
   brew test researchbuddy
   ```
6. Commit and push the tap repo.

## Skill

This tap also ships a maintainer skill at:

```text
skills/researchbuddy-tap-maintainer
```

Use it when an agent needs to bump the formula or validate the tap release.
