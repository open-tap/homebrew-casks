cask "uvtools" do
  arch arm: "arm64", intel: "x64"
  os macos: "osx", linux: "linux"
  url_end = on_system_conditional macos: "zip", linux: "AppImage"

  version "7.1.0"
  sha256 arm:          "fd6166e12463d219c1d32a98c88d00619df3eeac0bf291202868b78caa27bcbd",
         intel:        "e12252d53479cf92c4dddb5f5688433b10353b987e17706cdbdfb06d1fd7501f",
         arm64_linux:  "61e903241386f70ba8f9736dc3aef380893f2bef2ab96c86ccc204bca6d3712d",
         x86_64_linux: "0b47bb54df049ebfa0a584f995af1b3570a42266e8e37db4c238be0a76b9b18a"

  on_macos do
    depends_on macos: :ventura

    app "UVtools.app"

    postflight_steps do
      run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
    end

    zap trash: [
      "~/Library/Preferences/com.UVtools.plist",
      "~/Library/Saved Application State/com.UVtools.savedState",
    ]
  end
  on_linux do
    app_image "UVtools_linux-#{arch}_v#{version}.AppImage",
              target: "UVtools.AppImage"
  end

  url "https://github.com/sn4k3/UVtools/releases/download/v#{version}/UVtools_#{os}-#{arch}_v#{version}.#{url_end}"
  name "UVtools"
  desc "MSLA/DLP, file analysis, calibration, repair, conversion and manipulation"
  homepage "https://github.com/sn4k3/UVtools"

  auto_updates true
end
