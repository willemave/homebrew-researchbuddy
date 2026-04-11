class Researchbuddy < Formula
  desc "AI-powered review research assistant with parallel crawling and synthesis"
  homepage "https://github.com/willemave/researchbuddy"
  url "https://github.com/willemave/researchbuddy/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "147535a9f07e22af8f2757213d793e9ff68c407ad85aae8ed73dd928c7a69e84"

  depends_on "ffmpeg"
  depends_on "uv"

  def install
    (bin/"researchbuddy").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      exec "#{Formula["uv"].opt_bin}/uv" tool run --from "git+https://github.com/willemave/researchbuddy.git@v0.1.5" researchbuddy "$@"
    SH
    pkgshare.install "skills"
    pkgshare.install "docs"
  end

  def caveats
    <<~EOS
      ResearchBuddy bootstraps the tagged CLI package through uv on first run:
        #{Formula["uv"].opt_bin}/uv tool run --from "git+https://github.com/willemave/researchbuddy.git@v0.1.5" researchbuddy

      Additional runtime setup:
        - Install Playwright browsers after bootstrap if `researchbuddy doctor` reports they are missing
        - Install and authenticate codex: codex login
        - Set at least one search provider key (EXA_API_KEY, TAVILY_API_KEY, or FIRECRAWL_API_KEY)
        - Optionally set SEARCH_PROVIDER to override auto-selection
        - In OpenClaw, first check ~/.openclaw/openclaw.json and reuse an existing exa/tavily/firecrawl key when the user approves
        - ResearchBuddy also auto-loads provider config from ~/.hermes/.env and ~/.openclaw/openclaw.json
        - Run `researchbuddy doctor` before first use

      Tap maintenance skill:
        #{opt_pkgshare}/skills/researchbuddy-cli
    EOS
  end

  test do
    assert_match "tool run --from", (bin/"researchbuddy").read
    assert_path_exists pkgshare/"skills/researchbuddy-cli/SKILL.md"
  end
end
