cask "vieb" do
  arch arm: "arm64-"

  version "12.12.1"
  sha256 arm:   "3cafffdb159528ae99742caf7f522bc82e4b837bf01885aabf11fd7e8486a649",
         intel: "2d15d225c46675cea39ac1b3d8cbb3c3499cd17491bab75b7865273dc13a1150"

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

  uninstall quit: "com.github.Jelmerro.Vieb"

  zap trash: [
    "~/Library/Application Support/Vieb",
    "~/Library/Caches/Vieb",
  ]
end
