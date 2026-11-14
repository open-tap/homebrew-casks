cask "animeflow" do
  version "2.6.8"
  sha256 "e6ba03a53f31fc293bd2c2c2ce06adc67152de855753d1d438d70d783cde5933"

  url "https://github.com/openAnimeFlow/AnimeFlow/releases/download/v#{version}/AnimeFlow-macos-#{version}.dmg"
  name "AnimeFlow"
  desc "Anime player with Bangumi sync and danmaku"
  homepage "https://web.ligg.top/"

  depends_on macos: :monterey

  app "anime_flow.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/anime_flow.app"]
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.FinderInfo", "{{appdir}}/anime_flow.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/com.example.animeFlow",
    "~/Library/Application Support/com.example.animeFlow",
    "~/Library/Caches/com.example.animeFlow",
    "~/Library/Containers/com.example.animeFlow",
    "~/Library/HTTPStorages/com.example.animeFlow",
    "~/Library/Preferences/com.example.animeFlow.plist",
    "~/Library/Saved Application State/com.example.animeFlow.savedState",
    "~/Library/WebKit/com.example.animeFlow",
  ]
end
