class Reviewbuddy < Formula
  desc "AI-powered review research assistant with parallel crawling and synthesis"
  homepage "https://github.com/willemave/reviewbuddy"
  url "https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "518074768af3ad36bc4432a417c3ce7abd9dce4c3f93fd247b11be0b11354344"

  depends_on "ffmpeg"
  depends_on "uv"

  def install
    (bin/"reviewbuddy").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      exec "#{Formula["uv"].opt_bin}/uv" tool run --from "git+https://github.com/willemave/reviewbuddy.git@v0.1.4" reviewbuddy "$@"
    SH
    pkgshare.install "skills"
    pkgshare.install "docs"
  end

  def caveats
    <<~EOS
      ReviewBuddy bootstraps the tagged CLI package through uv on first run:
        #{Formula["uv"].opt_bin}/uv tool run --from "git+https://github.com/willemave/reviewbuddy.git@v0.1.4" reviewbuddy

      Additional runtime setup:
        - Install Playwright browsers after bootstrap if `reviewbuddy doctor` reports they are missing
        - Install and authenticate codex: codex login
        - Set at least one search provider key (EXA_API_KEY, TAVILY_API_KEY, or FIRECRAWL_API_KEY)
        - Optionally set SEARCH_PROVIDER to override auto-selection
        - In OpenClaw, first check ~/.openclaw/openclaw.json and reuse an existing exa/tavily/firecrawl key when the user approves
        - ReviewBuddy also auto-loads provider config from ~/.hermes/.env and ~/.openclaw/openclaw.json
        - Run `reviewbuddy doctor` before first use

      Tap maintenance skill:
        #{opt_pkgshare}/skills/reviewbuddy-cli
    EOS
  end

  test do
    assert_match "tool run --from", (bin/"reviewbuddy").read
    assert_path_exists pkgshare/"skills/reviewbuddy-cli/SKILL.md"
  end
end
