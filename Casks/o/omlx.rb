cask "omlx" do
  version "0.7.1rc1"
  sha256 "a9efb6eada12b5765de26c456342ed6bc2faefbeafae07ab4c7bcf544aaf352e"

  url "https://github.com/jundot/omlx/releases/download/v#{version}/oMLX-#{version}-macos26-27.dmg"
  name "oMLX"
  desc "MLX server with smart caching"
  homepage "https://omlx.ai/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+[\w._-]*)$/i)
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
