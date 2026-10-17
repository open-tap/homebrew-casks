cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-16"
  sha256 arm:   "3dba0e80f3f8961d0ad0360a3bafda8a6bd97558ccd880748fe665f15eb39688",
         intel: "f37dc6d7b23571902f2b04784fe26e13c3e7ee14f697d66f417b8a611a5b0cf5"

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
