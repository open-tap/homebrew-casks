cask "vrcx" do
  arch arm: "arm64", intel: "x64"
  url_end = on_system_conditional macos: "dmg", linux: "AppImage"

  version "2026.11.14"
  sha256 arm:          "abe73873bc3ab6486c963b18b91a9c286fa1dc4145ab07696e007e2d54c3b38b",
         intel:        "40e7bc49ea5d1e0d88c6fb333ab7637e06b5ea0e6fa0b77d1d61080b1c5437a7",
         arm64_linux:  "a757cc7d7a76d0f77aef2a7ba702600385ca815bf3202af9f8e8b09740cefb6b",
         x86_64_linux: "9cdb552e3f43e3ac4ecbdea051e0873b9397a0fe8eea8e8392aa9e30862cea08"

  on_macos do
    depends_on macos: :sonoma

    app "VRCX.app"

    zap trash: [
      "~/Library/Application Support/VRCX",
      "~/Library/Caches/app.vrcx",
      "~/Library/Caches/VRCX",
      "~/Library/HTTPStorages/app.vrcx",
      "~/Library/Preferences/app.vrcx.plist",
      "~/Library/Saved Application State/app.vrcx.savedState",
      "~/Library/WebKit/app.vrcx",
    ]
  end
  on_linux do
    app_image "VRCX_#{version}_#{arch}.AppImage",
              target: "VRCX.AppImage"

    zap trash: [
      "~/.cache/VRCX",
      "~/.config/VRCX",
    ]
  end

  url "https://github.com/vrcx-team/VRCX/releases/download/v#{version}/VRCX_#{version}_#{arch}.#{url_end}"
  name "VRCX"
  desc "Friendship management tool for VRChat"
  homepage "https://github.com/vrcx-team/VRCX"

  livecheck do
    url :url
    strategy :github_latest
  end
end
