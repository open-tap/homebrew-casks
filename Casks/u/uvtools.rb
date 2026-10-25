cask "uvtools" do
  arch arm: "arm64", intel: "x64"
  os macos: "osx", linux: "linux"
  url_end = on_system_conditional macos: "zip", linux: "AppImage"

  version "7.1.1"
  sha256 arm:          "1de1b19636d250eac4f20fd6b0031d2e63b2d0387f6456990ef70368b6040d07",
         intel:        "10f39e7942be86fd86270f9b2fd2f9b9c13a077b3d82e602842bd22772d469c6",
         arm64_linux:  "94204c9664ea2837a88368205b67e316b80fc114acc3f737758d3f1f59379d26",
         x86_64_linux: "5c56be14e221ccd4c7bf7aa64091db255146dd9692a482d908335df6ef7d6d41"

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
