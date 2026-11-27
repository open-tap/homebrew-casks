cask "anich" do
  version "1.5.28"
  sha256 "4454b8cfef67db0f0a93bd7f718f83365f1e6e443dab23ca24a9243772fda936"

  url "https://github.com/Sle2p/AniCh/releases/download/#{version}/anich-macos-#{version}.dmg"
  name "AniCh"
  desc "Anime player with danmaku and super-resolution"
  homepage "https://github.com/Sle2p/AniCh"

  depends_on :macos

  app "anich.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/anich.app"]
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.FinderInfo", "{{appdir}}/anich.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/app.anich",
    "~/Library/Application Support/app.anich",
    "~/Library/Caches/app.anich",
    "~/Library/Containers/app.anich",
    "~/Library/HTTPStorages/app.anich",
    "~/Library/Preferences/app.anich.plist",
    "~/Library/Saved Application State/app.anich.savedState",
    "~/Library/WebKit/app.anich",
  ]
end
