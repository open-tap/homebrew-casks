cask "secure-pipes" do
  version "0.99.12,a813da7f43bcfc5"
  sha256 "f64cd685bde0ecae0cae77a8db432d62858e73fcd86be39ee64f01b015ad29e0"

  url "https://www.opoet.com/pyro/index.php/files/download/#{version.csv.second}"
  name "Secure Pipes"
  desc "Manage SSH tunnels"
  homepage "https://www.opoet.com/pyro/index.php/"

  livecheck do
    url :homepage
    regex(/filename.*?Secure\s+Pipes\s+v?(\d+(?:\.\d+)+)\.dmg/i)
    strategy :page_match do |page, regex|
      download_hash = page.scan(%r{opoet\.com/pyro/index.php/files/download/(.+)["'< ]}i).flatten.first
      next if download_hash.blank?

      merged_headers = Homebrew::Livecheck::Strategy.page_headers(
        "https://www.opoet.com/pyro/index.php/files/download/#{download_hash}",
      ).reduce(&:merge)

      match = merged_headers["content-disposition"]&.match(regex)
      next if match.blank?

      "#{match[1]},#{download_hash}"
    end
  end

  depends_on macos: :monterey

  app "Secure Pipes.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{staged_path}}"]
  end
end
