cask "animeflow" do
  version "2.7.0"
  sha256 "a9c54823acbefe197fb00fea963022c7f66d2d62aa2ec6014bd4baa6205dfaab"

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
