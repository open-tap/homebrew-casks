cask "servo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026-10-15"
  sha256 arm:   "d01b63f61ac0ae17ad26a0bca009175947a27c9bdfc20a806084f222b72a5811",
         intel: "316b5f44378a0e9216f4e15bf999e39932acc3f65fd4bed14e3e9a49cbfda11b"

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
