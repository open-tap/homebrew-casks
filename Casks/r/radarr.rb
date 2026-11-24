cask "radarr" do
  arch arm: "arm64", intel: "x64"

  version "7.0.3.10918"
  sha256 arm:   "11eb85253a96940fc34c112ec609f3df6f12c7f4b82530ad30c85eb4ef2368d9",
         intel: "3316b448fd96c541b2e42448ed28df80ebc73b6d504e0d89e7845bffcef03178"

  url "https://github.com/Radarr/Radarr/releases/download/v#{version}/Radarr.master.#{version}.osx-app-core-#{arch}.zip"
  name "Radarr"
  desc "Fork of Sonarr to work with movies à la Couchpotato"
  homepage "https://radarr.video/"

  livecheck do
    url "https://radarr.servarr.com/v1/update/master/changes?os=osx&arch=#{arch}"
    strategy :json do |json|
      json.map { |item| item["version"] }
    end
  end

  auto_updates true
  depends_on :macos

  app "Radarr.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: "~/.config/Radarr"
end
