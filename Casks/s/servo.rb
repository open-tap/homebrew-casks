cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-20"
  sha256 arm:   "c7a1b0064742ecc7bc5000177ee21d41d2af62b7da2edae3ed8631f6470dc0a0",
         intel: "909afe0e24f2072f0f3dac2dd95b81e986818043e627af2b9ac1df09ccacb527"

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
