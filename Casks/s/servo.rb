cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-18"
  sha256 arm:   "be9c06521712b99598822d63752c0ac03e336f3161ae3180745218649d1577d1",
         intel: "cda0615988e4271647404dcbf709f8d58b2bdfcfd3b2bf9455d7b5407dec0700"

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
