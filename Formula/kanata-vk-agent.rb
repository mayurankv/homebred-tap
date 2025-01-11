class KanataVkAgent < Formula
  version "1"
  sha256 "e9ad5ef2b08914bbfe2caa0bf2a13f3752ad5d1c3d58f581592c876b6b837945"

  desc ""
  homepage "https://github.com/devsunb/kanata-vk-agent"
  url "https://github.com/devsunb/kanata-vk-agent"
  license ""

  depends_on "rust"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
  end

  test do
    system "false"
  end
  
  service do
    run [opt_bin/"kanata-vk-agent"]
  end
end

