class Reviewbuddy < Formula
  include Language::Python::Virtualenv

  desc "AI-powered review research assistant with parallel crawling and synthesis"
  homepage "https://github.com/willemave/reviewbuddy"
  url "https://github.com/willemave/reviewbuddy/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "26120c196daec1bf6ae19876e5f1734d0108aba0f9ef60f7f9b8a25f7ae6448e"

  depends_on "ffmpeg"
  depends_on "python@3.13"

  def install
    virtualenv = virtualenv_create(libexec, Formula["python@3.13"].opt_bin/"python3.13")
    system virtualenv.root/"bin/pip", "install", "."
    bin.install_symlink virtualenv.root/"bin/reviewbuddy"
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
