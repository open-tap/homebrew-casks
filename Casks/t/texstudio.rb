cask "texstudio" do
  arch arm: "-m1"

  on_ventura :or_older do
    version "4.9.8"
    sha256 arm:   "e66fd2a6305e88ac88d47deee3306f449d29b1f3a8e49f382fcaea2a79f29373",
           intel: "8c87cc80cd56af21663b3c7d9b411440e573d108724c01dce0d0e8c6db61dabc"
    livecheck do
      skip "Legacy version"
    end
  end
  on_sonoma :or_newer do
    version "4.9.9"
    sha256 arm:   "6e1814b234fc6a018fcca62f847f95badd2437bfb2baddcffab3d430ac861f46",
           intel: "485e79c6d7ceb588002ba33ea1bbc9513352fcdd22f27a75704bb54a344de176"
    livecheck do
      url :url
      strategy :github_latest
    end
  end

  url "https://github.com/texstudio-org/texstudio/releases/download/#{version}/texstudio-#{version}-osx#{arch}.zip"
  name "TeXstudio"
  desc "LaTeX editor"
  homepage "https://texstudio.org/"

  depends_on macos: :ventura

  app "texstudio-#{version}-osx#{arch}.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "texstudio"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/texstudio.sfl*",
    "~/Library/Preferences/texstudio.plist",
    "~/Library/Saved Application State/texstudio.savedState",
  ]
end
