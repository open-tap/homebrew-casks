cask "omlx" do
  version "0.8.4"
  sha256 "445c3d42b1ac5dbdd1d8f1eadca0ad4e35dded846026b3ca3d8537dd7ce08a0b"

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

  uninstall quit: "app.omlx"

  # zap trash: []
end
