cask "appium-inspector" do
  arch arm: "arm64", intel: "x64"

  on_monterey :or_older do
    version "2026.7.1"
    sha256 arm:   "0d67af30dacf5cc84545ab7356375349b8e0594a01f6f96dc5d5268cec730bd4",
           intel: "5c855085441a591d86c24ea387c651e64a24248942bf32c23653788c26b15df1"

    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "2026.11.5"
    sha256 arm:   "6b8783e8f080d17e0417f807b9e0bc3575b0c7483f8f69b7269979db4128689c",
           intel: "6b8783e8f080d17e0417f807b9e0bc3575b0c7483f8f69b7269979db4128689c"

    # Not every GitHub release provides a file for macOS, so we check multiple
    # recent releases instead of only the "latest" release.
    livecheck do
      url :url
      regex(/^Appium.*?v?(\d+(?:\.\d+)+)[._-]mac[._-]#{arch}\.(?:dmg|pkg|zip)$/i)
      strategy :github_releases do |json, regex|
        json.map do |release|
          next if release["draft"] || release["prerelease"]

          release["assets"]&.map do |asset|
            match = asset["name"]&.match(regex)
            next if match.blank?

            match[1]
          end
        end.flatten
      end
    end
  end

  url "https://github.com/appium/appium-inspector/releases/download/v#{version}/Appium-Inspector-#{version}-mac-#{arch}.zip"
  name "Appium Inspector GUI"
  desc "GUI inspector for mobile apps"
  homepage "https://github.com/appium/appium-inspector/"

  depends_on macos: :monterey

  app "Appium Inspector.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/appium-inspector",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/io.appium.inspector.sfl*",
    "~/Library/Logs/Appium Inspector",
    "~/Library/Preferences/io.appium.inspector.plist",
    "~/Library/Saved Application State/io.appium.inspector.savedState",
  ]
end
