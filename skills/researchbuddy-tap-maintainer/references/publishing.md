# Publishing ResearchBuddy To Homebrew

## Release Inputs

- Source repository: `https://github.com/willemave/researchbuddy`
- Release tarball pattern: `https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.7.tar.gz`
- Formula file: `Formula/researchbuddy.rb`

## Release Checklist

1. Push the source tag, for example `v0.1.7`.
2. Compute the release SHA:
   ```bash
   curl -L https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.7.tar.gz | shasum -a 256
   ```
3. Regenerate `constraints.txt` from the source `uv.lock` and ensure the formula installs it.
4. Update the formula fields:
   - `url`
   - `sha256`
5. Validate:
   ```bash
   brew audit --strict --online researchbuddy
   brew install --build-from-source ./Formula/researchbuddy.rb
   brew test researchbuddy
   ```
6. Commit and push the tap changes.

## Runtime Notes

- `researchbuddy` still needs `codex` installed and authenticated.
- Playwright browsers are installed into the uv tool runtime by `researchbuddy doctor --fix`.
- The Homebrew wrapper passes `--constraints "$(brew --prefix)/opt/researchbuddy/share/researchbuddy/constraints.txt"` so first-run uv resolution stays aligned with the source lockfile.
- Required environment:
  - one search provider key: `EXA_API_KEY`, `TAVILY_API_KEY`, or `FIRECRAWL_API_KEY`
  - optional override: `SEARCH_PROVIDER`
- Additional auto-detected config sources:
  - `~/.hermes/.env`
  - `~/.openclaw/.env`
  - `~/.openclaw/openclaw.json`
