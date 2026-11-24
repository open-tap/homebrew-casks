cask "prowlarr" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0.5799"
  sha256 arm:   "7df80b443ea245886fc07fa5b9ed469661a3914e1220db02707199531113849b",
         intel: "032471baec6e096c82d8fb430047ff29248f59752b27174d4461acad120d87aa"

  url "https://github.com/Prowlarr/Prowlarr/releases/download/v#{version}/Prowlarr.master.#{version}.osx-app-core-#{arch}.zip"
  name "Prowlarr"
  desc "Indexer manager/proxy for various PVR apps"
  homepage "https://prowlarr.com/"

  livecheck do
    url "https://prowlarr.servarr.com/v1/update/master/changes?os=osx&arch=#{arch}"
    strategy :json do |json|
      json.map { |item| item["version"] }
    end
  end

  auto_updates true
  depends_on :macos

  app "Prowlarr.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: "~/.config/Prowlarr"
end
