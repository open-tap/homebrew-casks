cask "chromium-gost" do
  arch arm: "arm64", intel: "amd64"

  on_monterey :or_older do
    version "150.0.7871.224"
    sha256 arm:   "9bc80d7ecd9caf43459d89d4c4880f95aae333b4a73ab6e886b59018cae1e2e7",
           intel: "e4dbe5b029c0c688c5c077e5818a9e2ad00caad76feb697f6c8f9d3b016f709a"
    livecheck do
      skip "Legacy version"
    end
  end
  on_ventura :or_newer do
    version "156.0.8078.114"
    sha256 arm:   "65a2e1aa319058b33b606285a00d73c468fdc6a8ab6c57ccc1f6072dfc78e80c",
           intel: "f8cac9760c544c767dac24f45282b48a8c4cb2ccf25212966ebbed62b030eb33"
    livecheck do
      url :url
      strategy :github_latest
    end
  end

  url "https://github.com/deemru/Chromium-Gost/releases/download/#{version}/chromium-gost-#{version}-macos-#{arch}.tar.bz2"
  name "Chromium-Gost"
  desc "Browser based on Chromium with support for GOST cryptographic algorithms"
  homepage "https://github.com/deemru/Chromium-Gost"

  depends_on macos: :monterey

  app "Chromium-Gost.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/Chromium",
    "~/Library/Caches/Chromium",
    "~/Library/Preferences/ru.cryptopro.chromium-gost.plist",
  ]
end
