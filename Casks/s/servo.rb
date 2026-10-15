cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-14"
  sha256 arm:   "429ba2917a9f08b9c89ea46baa65ec5b6993028e9861db3091283d1e488f8f39",
         intel: "f57cb80d42f8db1db86b61af77c9047c253165f4d9123c79c9bd9dd977e74b73"

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
