cask "llauncher" do
  version "1.3.5"
  sha256 "94852d4d0e90c7f6c0878e2e6266e6fafa36b9736fd713b2cb91f6159a136570"

  url "https://github.com/AugustLigh/LLauncher/releases/download/#{version}/LLauncher_#{version}_universal.dmg"
  name "LLauncher"
  desc "Launcher for Arknights: Endfield"
  homepage "https://github.com/AugustLigh/LLauncher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "LLauncher.app"

  zap trash: [
    "~/Library/Application Support/com.llauncher.macos",
    "~/Library/Application Support/llauncher",
    "~/Library/Caches/com.llauncher.macos",
    "~/Library/Caches/llauncher",
    "~/Library/HTTPStorages/com.llauncher.macos",
    "~/Library/Preferences/com.llauncher.macos.plist",
    "~/Library/Saved Application State/com.llauncher.macos.savedState",
    "~/Library/WebKit/com.llauncher.macos",
  ]
end
