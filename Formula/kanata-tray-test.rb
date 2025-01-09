class KanataTrayTest < Formula
  version "v0.5.2"
  sha256 "59fd53b0926ca64fbf59249a93f99cb90e7afdbe64d16dc65931974cdd00570e"

  desc "Menu bar application for controlling kanata and viewing kanata layer state"
  homepage "https://github.com/rszyma/kanata-tray"
  url "https://github.com/rszyma/kanata-tray/releases/download/#{version}/kanata-tray-macos"
  license "GPL-3.0-only"
  head "https://github.com/rszyma/kanata-tray.git", branch: "main"

  depends_on "kanata"

  def install
    bin.install "kanata-tray-macos" => "kanata-tray-test"
  end
end
