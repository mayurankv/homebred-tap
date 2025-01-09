class KanataTray < Formula
  version "v0.5.2"
  sha256 "59fd53b0926ca64fbf59249a93f99cb90e7afdbe64d16dc65931974cdd00570e"

  desc "Menu bar application for controlling kanata and viewing kanata layer state"
  homepage "https://github.com/rszyma/kanata-tray"
  url "https://github.com/rszyma/kanata-tray/releases/download/#{version}/kanata-tray-macos"
  license "GPL-3.0-only"
  head "https://github.com/rszyma/kanata-tray.git", branch: "main"

  depends_on "kanata"

  def install
    bin.install "kanata-tray-macos" => "kanata-tray"
  end

  #TODO: Does this work?
  def post_install
    system "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate"
  end

  #TODO: Does this work?
  def caveats
    <<~EOS
      To ensure the Karabiner Virtual HID Device daemon can run, ensure that the Driver Extension is allowed by;

        - Go to System Settings > General > Extensions > Driver Extensions
        - Turn .Karabiner-VirtualHIDDevice-Manager.app on
    EOS
  end

  # def plist
  #   <<~EOS
  #     <?xml version='1.0' encoding='UTF-8'?>
  #     <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  #     <plist version='1.0'>
  #       <dict>
  #         <key>Label</key>
  #         <string>#{plist_name}</string>
  #         <key>ProgramArguments</key>
  #         <array>
  #           <string>sudo</string>
  #           <string>#{opt_bin}/kanata-tray</string>
  #           <string>&</string>
  #           <string>sudo</string>
  #           <string>-/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string> #TODO: Does this work?
  #           <string>&</string>
  #           <string>wait</string>
  #         </array>
  #         <key>RunAtLoad</key>
  #         <true/>
  #         <key>KeepAlive</key>
  #         <dict>
  #           <key>SuccessfulExit</key>
  #           <false/>
  #           <key>Crashed</key>
  #           <true/>
  #         </dict>
  #         <key>StandardOutPath</key>
  #         <string>#{var}/log/kanata-tray.log</string>
  #         <key>StandardErrorPath</key>
  #         <string>#{var}/log/kanata-tray.log</string>
  #       </dict>
  #     </plist>
  #   EOS
  # end

  # <key>ProcessType</key>
  # <string>Interactive</string>
  # <key>Nice</key>
  # <integer>-30</integer>

  #TODO: Update with https://github.com/dawidd6/action-homebrew-bump-formula or https://github.com/mislav/bump-homebrew-formula-action
  #TODO: Test with `brew audit --new --formula kanata-tray`, `HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source --verbose --debug foo`

  service do
    # sudo "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
    # sudo kanata-tray
    # run [opt_bin/"kanata-tray", "&", "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"]
    run ["sudo", opt_bin/"kanata-tray", "&", "sudo", "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon", "&", "wait"]
    keep_alive true
    require_root true
    # process_type :interactive
    working_dir HOMEBREW_PREFIX
    log_path var/"log/kanata-tray.log"
    error_log_path var/"log/kanata-tray.log"
    # sockets "tcp://127.0.0.1:5829"
  end

  # test do
  #   system "#{opt_bin}/kanata-tray --version"
  # end
end
