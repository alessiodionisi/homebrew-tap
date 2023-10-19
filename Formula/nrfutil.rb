class Nrfutil < Formula
  desc "Unified command line utility for Nordic products."
  homepage "https://www.nordicsemi.com/Products/Development-tools/nRF-Util"
  url "https://developer.nordicsemi.com/.pc-tools/nrfutil/universal-osx/nrfutil"
  version "7.6.0"
  sha256 "229af1183c16cef8e18554ef3a922cb56f16eb7ee8dce76d16a0ace94e7fc6d1"
  license "LicenseRef-Nordic-1-Clause"

  
  def install
    bin.install "nrfutil"
  end

  test do
    system "#{bin}/nrfutil", "--help"
  end
end
