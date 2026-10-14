cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-13"
  sha256 arm:   "d3eff46ae5d953f608a65d6e5de87ad8c0e62290b269f8050617c353a4668e4e",
         intel: "a3b3a592dfdb545b0014987c77d47e011679e2ace42f60124e73ffe16aa61930"

  url "https://github.com/servo/servo-nightly-builds/releases/download/#{version}/servo-#{arch}-apple-darwin.dmg"
  name "Servo"
  desc "Parallel browser engine"
  homepage "https://servo.org/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:[.-]\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Servo.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: "~/Library/Application Support/Servo"
end
