cask "finewine-patcher" do
  version "3.0.0"
  sha256 "47fb91986aef867a81539d6e96d1afd635afeacac7eb4b8337c8fa5a52a223a2"

  url "https://github.com/stoicswe/Endfield_FineWine/releases/download/#{version}/FineWine.Patcher.app.zip"
  name "FineWine Patcher"
  desc "Patch CrossOver to run Arknights: Endfield"
  homepage "https://github.com/stoicswe/Endfield_FineWine"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "FineWine Patcher.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Caches/io.github.stoicswe.FineWinePatcher",
    "~/Library/Preferences/io.github.stoicswe.FineWinePatcher.plist",
    "~/Library/Saved Application State/io.github.stoicswe.FineWinePatcher.savedState",
  ]

  caveats <<~EOS
    Running Arknights: Endfield requires a licensed installation of CrossOver.
    This patcher currently targets CrossOver 26.3.0; other versions may not work.
    Rosetta 2 is required to run the bundled Wine modules.
  EOS
end
