cask "macstroke" do
  on_monterey :or_older do
    version "2.0.5"
    sha256 "113116367df18a2d3278d9540afdb0476f6b45dd6fbd09a565c9c038bb5e1a88"

    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "3.1.9"
    sha256 "e1d6ec536202e1edaf3d3f3c70adae941370652bfd4d51a3c2af0a2448e85def"
  end

  url "https://github.com/mtjo/MacStroke/releases/download/#{version}/MacStroke.zip"
  name "MacStroke"
  desc "Configurable global mouse gestures"
  homepage "https://github.com/mtjo/MacStroke/"

  depends_on :macos

  app "MacStroke.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Scripts/net.mtjo.MacStroke.FinderSyncExtension",
    "~/Library/Caches/MacStroke",
    "~/Library/Caches/net.mtjo.MacStroke",
    "~/Library/Containers/net.mtjo.MacStroke.FinderSyncExtension",
    "~/Library/Cookies/net.mtjo.MacStroke.binarycookies",
    "~/Library/Preferences/net.mtjo.MacStroke.plist",
  ]
end
