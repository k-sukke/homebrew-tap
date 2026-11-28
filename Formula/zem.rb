class Zem < Formula
  desc "Zephyr Environment Manager: declarative, isolated Zephyr RTOS environments"
  homepage "https://github.com/k-sukke/zem"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.3.0/zem-aarch64-apple-darwin.tar.xz"
      sha256 "9fc2527b37bf678edb74fd792113106f3c96b9765a16d03907e2bfea3ef9f389"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.3.0/zem-x86_64-apple-darwin.tar.xz"
      sha256 "39bd394695ce5d7db9ec1305d0bcbd8ae1a5bad250e9b67d549f5d0691e7a39a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.3.0/zem-aarch64-unknown-linux-musl.tar.xz"
      sha256 "00a054cfcaae77b361af92a4f8c566a7b692a8cd6c80eea6b05cb521b6cb4306"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.3.0/zem-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e1061fc724323ae8109a505a532f81ea7d59b429f13b8f78751479f8b2bf271a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zem"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zem"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zem"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zem"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
