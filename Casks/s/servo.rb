cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-19"
  sha256 arm:   "54827644800b0d817ea89bc4e6e8a2c9bdbff5406900d4ff02efd21f71dd1c18",
         intel: "90dd584405f9b58c266ac041260952383f1b6819dce6dab74365eb8e54be6b82"

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
