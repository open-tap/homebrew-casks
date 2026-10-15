cask "salesforce-cli" do
  arch arm: "arm64", intel: "x64"

  version "2.154.4,6ed132b"
  sha256 arm:   "35c1e7b11c86d51865f54312cc2f7decae09a5aa7738b317cbc51523b31a431c",
         intel: "1e071de2cc4d75a5a3a65f5211247ae8888fab19a35274614e60b3644f92fece"

  url "https://github.com/salesforcecli/cli/releases/download/#{version.csv.first}/sf-v#{version.csv.first}-#{version.csv.second}-#{arch}.pkg"
  name "Salesforce CLI"
  desc "CLI tools for Salesforce"
  homepage "https://developer.salesforce.com/tools/salesforcecli"

  livecheck do
    url "https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-darwin-#{arch}-buildmanifest",
        user_agent: :browser
    strategy :json do |json|
      next if json["version"].blank? || json["sha"].blank?

      "#{json["version"]},#{json["sha"]}"
    end
  end

  depends_on :macos

  pkg "sf-v#{version.csv.first}-#{version.csv.second}-#{arch}.pkg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall pkgutil: "com.salesforce.cli",
            delete:  [
              "/usr/local/bin/sf",
              "/usr/local/bin/sfdx",
            ]

  zap trash: [
    "~/.cache/sf",
    "~/.config/sf",
    "~/.local/share/sf",
    "~/.sf",
  ]
end
