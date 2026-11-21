cask "omlx" do
  version "0.8.1"
  sha256 "ff8115b3ab7f583125720dfaa42f8a65a4bc91776f1a3b4291fcb9d3ae60f9da"

  url "https://github.com/jundot/omlx/releases/download/v#{version}/oMLX-#{version}-macos26-27.dmg"
  name "oMLX"
  desc "MLX server with smart caching"
  homepage "https://omlx.ai/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  # macos26 version defines the minimum OS as macos15
  depends_on macos: :sequoia

  app "oMLX.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  # zap trash: []
end
