class Researchbuddy < Formula
  desc "AI-powered review research assistant with parallel crawling and synthesis"
  homepage "https://github.com/willemave/researchbuddy"
  url "https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "90200dc035d5b79cb439f29a17ad7182770975417d1b7c838d910eada8d266de"

  depends_on "ffmpeg"
  depends_on "uv"

  def install
    pkgshare.install "constraints.txt"
    pkgshare.install "skills"
    pkgshare.install "docs"

    (bin/"researchbuddy").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      export RESEARCHBUDDY_SKILL_DIR="#{opt_pkgshare}/skills/research"
      exec "#{Formula["uv"].opt_bin}/uv" tool run --python "3.11" --constraints "#{opt_pkgshare}/constraints.txt" --from "git+https://github.com/willemave/researchbuddy.git@v0.1.7" researchbuddy "$@"
    SH
  end

  def caveats
    <<~EOS
      ResearchBuddy bootstraps the tagged CLI package through uv on first run:
        #{Formula["uv"].opt_bin}/uv tool run --python 3.11 --constraints "#{opt_pkgshare}/constraints.txt" --from "git+https://github.com/willemave/researchbuddy.git@v0.1.7" researchbuddy

      Additional runtime setup:
        - Run `researchbuddy doctor --fix` to create local state and install Playwright browsers into the uv tool runtime
        - Install and authenticate codex: codex login
        - Configure at least one search provider key through environment, ~/.hermes/.env, ~/.openclaw/.env plus ~/.openclaw/openclaw.json, or manual ResearchBuddy .env
        - Optionally set SEARCH_PROVIDER to override auto-selection
        - In OpenClaw, first check ~/.openclaw/openclaw.json and reuse an existing exa/tavily/firecrawl key when the user approves
        - ResearchBuddy auto-loads provider config from ~/.hermes/.env, ~/.openclaw/.env, and ~/.openclaw/openclaw.json without copying credentials
        - Install the OpenClaw skill with: researchbuddy skills install openclaw --scope shared
        - Run `researchbuddy doctor` before first use

      Bundled research skill:
        #{opt_pkgshare}/skills/research
    EOS
  end

  test do
    assert_match "tool run --python", (bin/"researchbuddy").read
    assert_match "--constraints", (bin/"researchbuddy").read
    assert_path_exists pkgshare/"constraints.txt"
    assert_path_exists pkgshare/"skills/research/SKILL.md"
  end
end
