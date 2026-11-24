cask "pynsource" do
  version "1.87"
  sha256 "663fe4a6ce1ff869b352d8d120db30fc1ef252abc120ad8c71304fa6f481055c"

  url "https://github.com/abulka/pynsource/releases/download/version-#{version}/pynsource-macos-version-#{version}.zip"
  name "Pynsource"
  desc "Reverse engineer Python source code into UML"
  homepage "https://www.pynsource.com/"

  livecheck do
    url :url
    regex(/^version[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on :macos

  app "Pynsource.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/PyNsource",
    "~/Library/Logs/pynsource",
    "~/Library/Preferences/PyNSource",
    "~/Library/Saved Application State/Pynsource.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
