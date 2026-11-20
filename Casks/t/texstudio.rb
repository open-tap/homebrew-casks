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
    version "4.9.10"
    sha256 arm:   "9a780ba055b0e2296aa1ca45dd4e733bdd5ae4b28c7c000623777a2af9037a03",
           intel: "9449bad280c5ba45c81f3f0dbef330b00eb20b1e92dad00fd1ef29f36e2fdc1c"
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
