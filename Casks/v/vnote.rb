cask "vnote" do
  version "4.14.0"

  on_monterey :or_older do
    sha256 "a08d0630fee2f2e43c6f84e84a6c63dd56cde85b0d2dfabfce48f1ded2ccb907"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal-macos12.dmg"
  end
  on_ventura :or_newer do
    sha256 "7d7650be91b7cd2e24857569a6e6efc2cd1d5b43da0e51b83c8145f16be8ee0b"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal.dmg"
  end

  name "VNote"
  desc "Note-taking platform"
  homepage "https://docs.vnote.fun/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "VNote.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/VNote",
    "~/Library/Preferences/com.vnotex.vnote.plist",
    "~/Library/Preferences/VNote",
  ]
end
