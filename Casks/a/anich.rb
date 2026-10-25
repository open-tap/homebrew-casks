cask "anich" do
  version "1.5.27"
  sha256 "0ee4d76f995259f0b1dc86adca332d6c5b1ccdbea7a51957366763c3393e16c4"

  url "https://github.com/Sle2p/AniCh/releases/download/#{version}/anich-macos-#{version}.dmg"
  name "AniCh"
  desc "Anime player with danmaku and super-resolution"
  homepage "https://github.com/Sle2p/AniCh"

  livecheck do
    url :url
    strategy :github_latest
  end

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
