# Publishing ResearchBuddy To Homebrew

## Release Inputs

- Source repository: `https://github.com/willemave/researchbuddy`
- Release tarball pattern: `https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.5.tar.gz`
- Formula file: `Formula/researchbuddy.rb`

## Release Checklist

1. Push the source tag, for example `v0.1.5`.
2. Compute the release SHA:
   ```bash
   curl -L https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.5.tar.gz | shasum -a 256
   ```
3. Update the formula fields:
   - `url`
   - `sha256`
4. Validate:
   ```bash
   brew audit --strict --online researchbuddy
   brew install --build-from-source ./Formula/researchbuddy.rb
   brew test researchbuddy
   ```
5. Commit and push the tap changes.

## Runtime Notes

- `researchbuddy` still needs `codex` installed and authenticated.
- Playwright browsers are installed after brew install with:
  - `$(brew --prefix)/opt/researchbuddy/libexec/bin/python -m playwright install`
- Required environment:
  - one search provider key: `EXA_API_KEY`, `TAVILY_API_KEY`, or `FIRECRAWL_API_KEY`
  - optional override: `SEARCH_PROVIDER`
- Additional auto-detected config sources:
  - `~/.hermes/.env`
  - `~/.openclaw/openclaw.json`
