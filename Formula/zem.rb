class Zem < Formula
  desc "Zephyr Environment Manager: declarative, isolated Zephyr RTOS environments"
  homepage "https://github.com/k-sukke/zem"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.1/zem-aarch64-apple-darwin.tar.xz"
      sha256 "fc27edcf7591334d0517599ac0d6f37e0638c7c4333b0691a2fa6ec8ba5432f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.1/zem-x86_64-apple-darwin.tar.xz"
      sha256 "2256b1a53f2daaf8462065463b5e4791ed9545964dd47bf671210e1570a3351e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.1/zem-aarch64-unknown-linux-musl.tar.xz"
      sha256 "475a01036a3e5b8cab1c0e2adf119dab1197592f85f1b336c5e29e93abbfe357"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.1/zem-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b0c7c95f0c1b4bc9c327310bcb6b0f6c8f1cf779e95345099e3fc2b5018c0220"
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
