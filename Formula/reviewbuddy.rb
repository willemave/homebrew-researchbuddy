class Reviewbuddy < Formula
  include Language::Python::Virtualenv

  desc "AI-powered review research assistant with parallel crawling and synthesis"
  homepage "https://github.com/willemave/reviewbuddy"
  url "https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_RELEASE_SHA256"
  version "0.1.0"

  depends_on "ffmpeg"
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
    pkgshare.install "skills"
    pkgshare.install "docs"
  end

  def caveats
    <<~EOS
      ReviewBuddy requires additional runtime setup:
        - Install Playwright browsers: #{opt_libexec}/bin/python -m playwright install
        - Install and authenticate codex: codex login
        - Set OPENAI_API_KEY and one search provider key (EXA_API_KEY, TAVILY_API_KEY, or FIRECRAWL_API_KEY)
        - Run `reviewbuddy doctor` before first use

      Tap maintenance skill:
        #{opt_pkgshare}/skills/reviewbuddy-tap-maintainer
    EOS
  end

  test do
    output = shell_output("#{bin}/reviewbuddy commands --agent")
    assert_match "ReviewBuddy CLI For Agents", output
    assert_match "reviewbuddy doctor", output
  end
end
