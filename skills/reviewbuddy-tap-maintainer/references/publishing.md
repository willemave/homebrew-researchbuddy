# Publishing ReviewBuddy To Homebrew

## Release Inputs

- Source repository: `https://github.com/willemave/reviewbuddy`
- Release tarball pattern: `https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.2.tar.gz`
- Formula file: `Formula/reviewbuddy.rb`

## Release Checklist

1. Push the source tag, for example `v0.1.2`.
2. Compute the release SHA:
   ```bash
   curl -L https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.2.tar.gz | shasum -a 256
   ```
3. Update the formula fields:
   - `url`
   - `sha256`
4. Validate:
   ```bash
   brew audit --strict --online reviewbuddy
   brew install --build-from-source ./Formula/reviewbuddy.rb
   brew test reviewbuddy
   ```
5. Commit and push the tap changes.

## Runtime Notes

- `reviewbuddy` still needs `codex` installed and authenticated.
- Playwright browsers are installed after brew install with:
  - `$(brew --prefix)/opt/reviewbuddy/libexec/bin/python -m playwright install`
- Required environment:
  - one search provider key: `EXA_API_KEY`, `TAVILY_API_KEY`, or `FIRECRAWL_API_KEY`
  - optional override: `SEARCH_PROVIDER`
- Additional auto-detected config sources:
  - `~/.hermes/.env`
  - `~/.openclaw/openclaw.json`
