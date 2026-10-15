cask "unity-android-support-for-editor" do
  version "6000.6.6f1,d20c9ac777da"
  sha256 "029f283d0424d078b238136e17a3139cfb074e0e57b08db0980ada1a4da568fb"

  url "https://download.unity3d.com/download_unity/#{version.csv.second}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-#{version.csv.first}.pkg"
  name "Unity Android Build Support"
  desc "Android target support for Unity"
  homepage "https://unity.com/products"

  livecheck do
    cask "unity"
  end

  depends_on cask: "unity"
  depends_on :macos

  pkg "UnitySetup-Android-Support-for-Editor-#{version.csv.first}.pkg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end

  uninstall pkgutil: "com.unity3d.AndroidPlayer-#{version.csv.first}"
end
