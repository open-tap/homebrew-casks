cask "treesheets" do
  version "3523"
  sha256 "c1203bca7833c468cdc910287f8c72d6d4bcbdb33a6087b748bc19ae2ab1a192"

  release_version = version.csv.second || version.csv.first
  url "https://github.com/aardappel/treesheets/releases/download/#{release_version}/TreeSheets-#{version.csv.first}-Darwin.dmg"
  name "TreeSheets"
  desc "Hierarchical spreadsheet and outline application"
  homepage "https://strlen.com/treesheets/"

  livecheck do
    url :url
    regex(%r{/v?(\d+(?:\.\d+)*)/TreeSheets[._-]v?(\d+(?:\.\d+)*)(?:[._-]Darwin)?\.dmg$}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        if match[2] == match[1]
          match[1]
        else
          "#{match[2]},#{match[1]}"
        end
      end
    end
  end

  depends_on :macos

  app "TreeSheets.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "dot3labs.TreeSheets"

  zap trash: [
    "~/Library/Preferences/com.strlen.TreeSheets.plist",
    "~/Library/Preferences/dot3labs.TreeSheets.plist",
    "~/Library/Preferences/TreeSheets Preferences",
    "~/Library/Saved Application State/dot3labs.TreeSheets.savedState",
  ]
end
