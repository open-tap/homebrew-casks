cask "vnote" do
  version "4.15.1"

  on_monterey :or_older do
    sha256 "a3386a24a26324c562e2dcd38cc082e5c4a043ee544b0ce6b9cb9590c598c40b"

    url "https://github.com/vnotex/vnote/releases/download/v#{version}/VNote-#{version}-mac-universal-macos12.dmg"
  end
  on_ventura :or_newer do
    sha256 "eb9f1418482bf5b9411f40d192557ba31c3f8a4687d142946a26562dc38fc62c"

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
