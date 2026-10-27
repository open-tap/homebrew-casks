cask "uvtools" do
  arch arm: "arm64", intel: "x64"
  os macos: "osx", linux: "linux"
  url_end = on_system_conditional macos: "zip", linux: "AppImage"

  version "7.1.2"
  sha256 arm:          "0fe329344102ab0326c143ea9200ec6f0fdb9708e747c178bc34b6e46cc0961f",
         intel:        "ffb14e9055d85b80c2c8556b6573d5560d911257f2eddc61d688dc7b9bedebc6",
         arm64_linux:  "484eae7e36f768760d8c6574f80ba99fb242ab25a942773e57d6c3d7825c9599",
         x86_64_linux: "417ffc54a3f75e0c6074b066876672983c37358b0e3e02a7c23952482ece928c"

  on_macos do
    depends_on macos: :ventura

    app "UVtools.app"

    postflight_steps do
      run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
    end

    zap trash: [
      "~/Library/Preferences/com.UVtools.plist",
      "~/Library/Saved Application State/com.UVtools.savedState",
    ]
  end
  on_linux do
    app_image "UVtools_linux-#{arch}_v#{version}.AppImage",
              target: "UVtools.AppImage"
  end

  url "https://github.com/sn4k3/UVtools/releases/download/v#{version}/UVtools_#{os}-#{arch}_v#{version}.#{url_end}"
  name "UVtools"
  desc "MSLA/DLP, file analysis, calibration, repair, conversion and manipulation"
  homepage "https://github.com/sn4k3/UVtools"

  auto_updates true
end
