cask "ultrastardeluxe" do
  arch arm: "ARM", intel: "x86"

  version "2026.10.0"
  sha256 arm:   "0832398d699b2c662fc4230e013b5eb8a663e758519e08956fa1a9217fc4acc3",
         intel: "af8fe4305bd9d81a66bcf871ca1f4a72cbcc49ea20ffa7d56c8441feed14a395"

  url "https://github.com/UltraStar-Deluxe/USDX/releases/download/v#{version}/UltraStarDeluxe-mac-#{arch}-#{version}.dmg"
  name "UltraStar Deluxe"
  desc "Karaoke game"
  homepage "https://usdx.eu/"

  depends_on :macos

  app "UltraStar Deluxe.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "org.ultrastardeluxe.ultrastardeluxe"

  zap trash: "~/Library/Application Support/UltraStarDeluxe1.3"
end
