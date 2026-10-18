cask "squirreldisk" do
  version "2.6.1"
  sha256 "13ce189cb60d1b3c7c2983c5a9618d6c9a0ea09788c8a4d050290ef59f897e0a"

  url "https://github.com/adileo/squirreldisk/releases/download/v#{version}/SquirrelDisk-macOS.dmg"
  name "SquirrelDisk"
  desc "Fast Disk Usage Analysis Tool - Built With Rust"
  homepage "https://squirreldisk.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "SquirrelDisk.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Caches/com.squirreldisk.dev",
    "~/Library/Preferences/com.squirreldisk.dev.plist",
    "~/Library/Saved Application State/com.squirreldisk.dev.savedState",
    "~/Library/WebKit/com.squirreldisk.dev",
  ]
end
