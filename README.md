# homebrew-reviewbuddy

Homebrew tap for [reviewbuddy](https://github.com/willemave/reviewbuddy).

## Install

```bash
brew tap willemave/reviewbuddy
brew install reviewbuddy
```

If another formula with the same name ever exists, use the fully qualified name:

```bash
brew install willemave/reviewbuddy/reviewbuddy
```

## Update the formula for a new ReviewBuddy release

1. Create and push a new tagged release in the source repo, for example `v0.1.2`.
2. Download the release tarball and compute its SHA256:
   ```bash
   curl -L https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.2.tar.gz | shasum -a 256
   ```
3. Update `Formula/reviewbuddy.rb` with the new `url` and `sha256`.
4. Validate locally:
   ```bash
   brew audit --strict --online reviewbuddy
   brew install --build-from-source ./Formula/reviewbuddy.rb
   brew test reviewbuddy
   ```
5. Commit and push the tap repo.

## Skill

This tap also ships a maintainer skill at:

```text
skills/reviewbuddy-tap-maintainer
```

Use it when an agent needs to bump the formula or validate the tap release.
