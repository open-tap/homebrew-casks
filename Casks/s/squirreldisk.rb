cask "squirreldisk" do
  version "2.5.1"
  sha256 "185048f88290b27e5ad8f588602e9767215c6acf9192c7926baa44c91c9515b8"

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
