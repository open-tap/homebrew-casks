cask "ntfstool" do
  version "4.7.2.7"
  sha256 "c6399f8a05223bbc2b88068da729b3a1d8ffdccff063bcd933b68ad982a65247"

  url "https://github.com/ntfstool/ntfstool/releases/download/#{version}/Ntfstool_#{version}_release.pkg"
  name "NTFSTool"
  desc "Utility that provides NTFS read and write support"
  homepage "https://github.com/ntfstool/ntfstool"

  auto_updates true
  depends_on :macos

  pkg "Ntfstool_#{version}_release.pkg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall quit:    "com.ntfstool.aile",
            pkgutil: "com.ntfstool.Ntfstool.pkg"

  zap trash: "~/.ntfstool"
end
