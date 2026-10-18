cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-17"
  sha256 arm:   "2a2dec50aceb930f9ae49952411e0156c362a16e1d261c82d605014ce9c2f38c",
         intel: "80302f640a1ed557a2a57b726cfdbf0fdd2de81413c208dfc6e4a8e5a5946793"

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
