cask "vieb" do
  arch arm: "arm64-"

  version "12.12.0"
  sha256 arm:   "0129ce5bb1dacaaf9329acab3d2a0a23301995f467d36709c505095ee2d6a9cc",
         intel: "5ce98e04bae2ef0ae1b5916904270c475b562c60aec18a250e82ee16fee906e5"

  url "https://github.com/Jelmerro/Vieb/releases/download/#{version}/Vieb-#{version}-#{arch}mac.zip"
  name "Vieb"
  desc "Vim Inspired Electron Browser"
  homepage "https://vieb.dev/"

  depends_on macos: :ventura

  app "Vieb.app"
  command_wrapper "vieb",
                  executable: "#{appdir}/Vieb.app/Contents/MacOS/Vieb"

  postflight_steps do
    run "/bin/chmod", args: ["-R", "+w", "{{staged_path}}/.homebrew-command-wrappers"]
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  zap trash: [
    "~/Library/Application Support/Vieb",
    "~/Library/Caches/Vieb",
  ]
end
