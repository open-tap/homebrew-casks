cask "mechvibes" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "-macos"
  url_end = on_system_conditional macos: "dmg", linux: "AppImage"

  version "3.5.11"
  sha256 arm:          "84dc0b0de73c2a1cbde77ed1db479033ebd01f0e2abb1e0d402277a9a9964ce4",
         intel:        "d1567047379c0174136c281e0d6e966a4fcb3b1e5b1823c3e39e848c956871b3",
         x86_64_linux: "685a072979194e76d33a0a311f508dc8448f8de440c5d6e9500e49a2becaf57e"

  on_macos do
    app "Mechvibes.app"

    postflight_steps do
      run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
    end

    zap trash: [
          "~/Library/Application Support/Mechvibes",
          "~/Library/Caches/com.hainguyents13.mechvibesdx",
          "~/Library/Preferences/com.electron.mechvibes.plist",
          "~/Library/Preferences/com.hainguyents13.mechvibesdx.plist",
          "~/Library/Saved Application State/com.electron.mechvibes.savedState",
          "~/Library/WebKit/com.hainguyents13.mechvibesdx",
        ],
        rmdir: "~/mechvibes_custom"
  end
  on_linux do
    depends_on arch: :x86_64

    app_image "mechvibes-#{version}-x86_64.AppImage", target: "Mechvibes.AppImage"

    zap trash: "~/.config/mechvibes"
  end

  url "https://github.com/hainguyents13/mechvibes/releases/download/v#{version}/mechvibes-#{version}#{os}-#{arch}.#{url_end}"
  name "Mechvibes"
  desc "Play mechanical keyboard sounds as you type"
  homepage "https://mechvibes.com/"
end
