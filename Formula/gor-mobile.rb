class GorMobile < Formula
  desc     "Android-aware overlay installer for Claude Code — superpowers-style workflow"
  homepage "https://github.com/gorban-dev/gor-mobile"
  url      "https://github.com/gorban-dev/gor-mobile/archive/refs/tags/v0.2.0.tar.gz"
  sha256   "8a0ecd95f8b651e20acb42585aa617440aee799f4c5a882459f80369d02af9ab"
  version  "0.2.0"
  license  "MIT"

  depends_on "git"
  depends_on "node"

  def install
    libexec.install Dir["*"]
    cd libexec do
      system "npm", "install", "--production=false", "--no-audit", "--no-fund"
      system "npm", "run", "build"
    end
    (bin/"gor-mobile").write_env_script libexec/"bin/gor-mobile.mjs",
      GOR_MOBILE_ROOT: libexec.to_s
  end

  def caveats
    <<~EOS
      To finish setup, run:
        gor-mobile init
        gor-mobile doctor
    EOS
  end

  test do
    assert_match "gor-mobile #{version}", shell_output("#{bin}/gor-mobile version")
  end
end
