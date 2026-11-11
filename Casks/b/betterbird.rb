cask "betterbird" do
  arch arm: "-arm64"

  version "153.7.0esr-bb13"
  sha256 arm:   "b5eacb2ba1c11b6e1b36c73898611246b0a7f38431a73dfbb4762116393a98d9",
         intel: "bf7f0dc3658acd28376fec734017846b630887d6ff1ee3d0e2aa07b5e8b25268"

  url "https://www.betterbird.eu/downloads/MacDiskImage/betterbird-#{version}.en-US.mac#{arch}.dmg"
  name "Betterbird"
  desc "Fine-tuned version of Mozilla Thunderbird"
  homepage "https://www.betterbird.eu/"

  livecheck do
    url "https://www.betterbird.eu/downloads/get.php?os=mac&lang=en-US&version=release"
    regex(/betterbird-([\d.]+[\w-]*)\.en-US\.mac\.dmg/i)
    strategy :header_match
  end

  auto_updates true
  depends_on :macos

  app "Betterbird.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.betterbird.sfl*",
    "~/Library/Caches/Thunderbird",
    "~/Library/Preferences/org.mozilla.betterbird.plist",
    "~/Library/Saved Application State/org.mozilla.betterbird.savedState",
    "~/Library/Thunderbird",
  ]

  caveats <<~EOS
    Language Packs available at https://www.betterbird.eu/downloads/index.php.
  EOS
end
