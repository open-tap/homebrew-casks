cask "animeflow" do
  version "2.6.6"
  sha256 "56bf582ef47d3f390204067e8170bf14629ffb0decccac58357ce36f7b842558"

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
