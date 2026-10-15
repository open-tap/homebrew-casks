cask "finewine-patcher" do
  version "1.2.3"
  sha256 "02d4a6c2668e49d0c8c14f4ac14aaeff71565ff9f21c1e22c4f3b63ead14ae98"

  url "https://github.com/stoicswe/Endfield_FineWine/releases/download/#{version}/FineWine.Patcher.app.zip"
  name "FineWine Patcher"
  desc "Patch CrossOver to run Arknights: Endfield"
  homepage "https://github.com/stoicswe/Endfield_FineWine"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

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
