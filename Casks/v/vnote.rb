cask "vnote" do
  version "4.9.0"

  on_monterey :or_older do
    sha256 "80f38a689697ff47d9a2a9b96b8c42c8dcf7f1f5e9fab7faeacb19dc8361a9f5"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal-macos12.dmg"
  end
  on_ventura :or_newer do
    sha256 "bb238255f9e17a38b8eb959e238ea6b2db3fd00cd3fe632718f7cb23acca4cd8"

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
