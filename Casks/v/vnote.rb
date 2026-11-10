cask "vnote" do
  version "4.14.2"

  on_monterey :or_older do
    sha256 "97abd1b66f87009e774f3fdea49b678dfbe3589ee87e7eea883b4493e2c6f569"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal-macos12.dmg"
  end
  on_ventura :or_newer do
    sha256 "89cedce7e8088619aa49f3bf86bae5493827faa60932d5d4f3d5d01af9ff285a"

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
