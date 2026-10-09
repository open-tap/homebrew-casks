cask "vnote" do
  on_monterey :or_older do
    version "4.8.0"
    sha256 "cae171f6465453ae86f13bf132ee2af12c2b08d608b42988f65ee6713f7a14aa"

    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "4.9.0"
    sha256 "bb238255f9e17a38b8eb959e238ea6b2db3fd00cd3fe632718f7cb23acca4cd8"

    livecheck do
      url :url
      strategy :github_latest
    end
  end

  url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal.dmg"
  name "VNote"
  desc "Note-taking platform"
  homepage "https://docs.vnote.fun/"

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
