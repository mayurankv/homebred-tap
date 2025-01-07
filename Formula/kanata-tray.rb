class KanataTray < Formula
  desc "Menu bar application for controlling kanata and viewing kanata layer state"
  homepage "https://github.com/rszyma/kanata-tray"
  url "https://github.com/rszyma/kanata-tray/releases/download/v0.5.2/kanata-tray-macos"
  sha256 "59fd53b0926ca64fbf59249a93f99cb90e7afdbe64d16dc65931974cdd00570e"
  license "GPL-3.0"
  head "https://github.com/rszyma/kanata-tray.git", branch: "main"

  depends_on "kanata"

  def install
    bin.install "kanata-tray-macos" => "kanata-tray"
  end

  service do
    run opt_bin/"kanata-tray"
    keep_alive true
    require_root true
    working_dir HOMEBREW_PREFIX
    log_path var/"log/kanata-tray.log"
    error_log_path var/"log/kanata-tray.log"
  end

  test do
    system bin/"kanata-tray", "--version"
  end
end
