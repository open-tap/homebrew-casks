cask "ntfstool" do
  version "4.7.2.18"
  sha256 "6abd2376f516c26cdbfd4891f4536831ef6187c4eb8f4f3669ae80474bb3bfe7"

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
