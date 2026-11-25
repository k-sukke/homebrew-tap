class Zem < Formula
  desc "Zephyr Environment Manager: declarative, isolated Zephyr RTOS environments"
  homepage "https://github.com/k-sukke/zem"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.3/zem-aarch64-apple-darwin.tar.xz"
      sha256 "f98e1736747cc2caf685066b5bc8decf1e0b1a43b0ddad128b7ce549ec8c070e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.3/zem-x86_64-apple-darwin.tar.xz"
      sha256 "431101ac40f316576abb10175b5ea071eb416e1b322c1e88a904519277fe10da"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.3/zem-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6592061cad9b37ae793cdd821fb82025749b57b641eaf468d9497c664b4136df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/k-sukke/zem/releases/download/v0.1.3/zem-x86_64-unknown-linux-musl.tar.xz"
      sha256 "97014e9e39972321efa2c6aee5d81d0c062f3599283571901e976c0f60861a66"
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
