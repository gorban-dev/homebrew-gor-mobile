class GorMobile < Formula
  desc     "Android-aware overlay installer for Claude Code — superpowers-style workflow"
  homepage "https://github.com/gorban-dev/gor-mobile"
  url      "https://github.com/gorban-dev/gor-mobile/archive/refs/tags/v0.3.1.tar.gz"
  sha256   "e97081b96a718db9ba3c97940de562a80a96f843e835789f272eae24b89872b4"
  version  "0.3.1"
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
