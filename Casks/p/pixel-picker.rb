cask "pixel-picker" do
  on_ventura :or_older do
    version "1.6.1"
    sha256 "31584144fc66cafdcd3d6689a69b9ab311621dbe1ee0713f2820a1a2a271903e"

    url "https://github.com/acheronfail/pixel-picker/releases/download/#{version}/Pixel.Picker.#{version}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_sonoma :or_newer do
    version "1.7.1"
    sha256 "31584144fc66cafdcd3d6689a69b9ab311621dbe1ee0713f2820a1a2a271903e"

    url "https://github.com/acheronfail/pixel-picker/releases/download/v#{version}/PixelPicker-#{version}-universal.dmg"
  end

  name "Pixel Picker"
  desc "Menu bar application to pick colours from your screen"
  homepage "https://github.com/acheronfail/pixel-picker"

  depends_on :macos

  app "Pixel Picker.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Logs/Pixel Picker",
    "~/Library/Preferences/Pixel Picker",
  ]
end
