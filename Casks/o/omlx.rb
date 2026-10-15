cask "omlx" do
  version "0.7.1.dev2"
  sha256 "1427acced6b6876427ac8ff7862ea1d961bacc692218f6ddcbd465ea8af9b78a"

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
