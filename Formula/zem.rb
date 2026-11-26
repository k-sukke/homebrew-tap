class Zem < Formula
  desc "Zephyr Environment Manager: declarative, isolated Zephyr RTOS environments"
  homepage "https://github.com/k-sukke/zem"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.4/zem-aarch64-apple-darwin.tar.xz"
      sha256 "f36394da9584caaac0a815218088ded0dea8d4c6ce540c76b67e364e300167a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.4/zem-x86_64-apple-darwin.tar.xz"
      sha256 "dedb18165fa9a815f7c5b1cc8fec7bc5dbd55c1adeec9f1e2a3db687c73c7032"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.4/zem-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f61bf5046a426c561da9e879d9ee906d517c44f8c6a38d4749709d433ac16199"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.4/zem-x86_64-unknown-linux-musl.tar.xz"
      sha256 "808a6c1c1f3ddcfea39951f550ab418f3645633228b97d9f7eeba71c04a975f9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
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
