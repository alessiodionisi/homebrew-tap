class Angle < Formula
  desc "A conformant OpenGL ES implementation for Windows, Mac, Linux, iOS and Android"
  homepage "https://chromium.googlesource.com/angle/angle"
  url "https://chromium.googlesource.com/angle/angle.git", branch: "main"
  version "main"

  depends_on "python" => :build

  resource "depot_tools" do
    url "https://chromium.googlesource.com/chromium/tools/depot_tools.git", branch: "main"
  end

  def install
    mkdir "build" do
      resource("depot_tools").stage do
        path = PATH.new(ENV["PATH"], Dir.pwd)
        with_env(PATH: path) do
          Dir.chdir(buildpath)

          system "python", "scripts/bootstrap.py"
          system "gclient", "sync"
          system "gn", "gen", "out/Release"
          system "autoninja", "-C", "out/Release"
          lib.install "out/Release/libabsl.dylib"
          lib.install "out/Release/libEGL.dylib"
          lib.install "out/Release/libGLESv2.dylib"
          lib.install "out/Release/libchrome_zlib.dylib"
          include.install Pathname.glob("include/*")
        end
      end
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libangle`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
