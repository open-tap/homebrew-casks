cask "finewine-patcher" do
  version "1.2.4"
  sha256 "e4d44d91b550cf6fe923cd906bbb8c2c84cf9ebf9ce16c0d87a5ea1773749037"

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
