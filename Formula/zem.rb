class Zem < Formula
  desc "Zephyr Environment Manager: declarative, isolated Zephyr RTOS environments"
  homepage "https://github.com/k-sukke/zem"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.0/zem-aarch64-apple-darwin.tar.xz"
      sha256 "96a0c5d869f7cb25039856d00dadcfb566193eff0ab35217719f1d2f5064cd3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.0/zem-x86_64-apple-darwin.tar.xz"
      sha256 "b89f63242eeebf2d1a0cbe2a2a5600aa9625fd1f783acf343a43dc33b8772511"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.0/zem-aarch64-unknown-linux-musl.tar.xz"
      sha256 "56ea846ca7806e318b9befcfbc521b91527ebd2b72ecaa0ca7bdacb59a62471a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.2.0/zem-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9f17e6adf845cbf7e01c3431e8f3f8500280d4028cdd7da6501d843bfc4c1d3b"
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
