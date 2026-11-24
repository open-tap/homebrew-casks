cask "ueli" do
  arch arm: "-arm64"

  version "9.29.1"
  sha256 arm:   "fd6001a9a0195823b6a890d710f38f74f7f2f8a1b3e7dae5153aa17f43cb3453",
         intel: "269d2dc6c30536b4a1bbeeda2e9e3a56fcd06e288b9bb4c9eddacf44f7df12da"

  url "https://github.com/oliverschwendener/ueli/releases/download/v#{version}/Ueli-#{version}#{arch}.dmg"
  name "Ueli"
  desc "Keystroke launcher"
  homepage "https://ueli.app/"

  depends_on macos: :monterey

  app "Ueli.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit: "ueli"

  zap trash: [
    "~/Library/Application Support/ueli",
    "~/Library/Logs/ueli",
    "~/Library/Preferences/com.electron.ueli.plist",
  ]
end
