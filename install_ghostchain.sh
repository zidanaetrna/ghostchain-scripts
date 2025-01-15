#!/bin/bash


echo -e '\e[94m'
echo -e '██████  ██    ██ ████████ ████████  ██████  ███    ██'
echo -e '██   ██ ██    ██    ██       ██    ██    ██ ████   ██'
echo -e '██████  ██    ██    ██       ██    ██    ██ ██ ██  ██'
echo -e '██   ██ ██    ██    ██       ██    ██    ██ ██  ██ ██'
echo -e '██████   ██████     ██       ██     ██████  ██   ████'
echo -e '                                                    '
echo -e '\e[0m'
echo -e "Join our Telegram channel: https://t.me/AirdropsButton"
echo -e "script by zidan"
echo -e " thanks to adolf tjep"

# Update system and install essential packages
echo "Updating system and installing essential packages..."
apt update
apt install -y ufw build-essential clang curl git make libssl-dev llvm libudev-dev protobuf-compiler

# UFW configuration
echo "Configuring UFW..."
ufw allow ssh
ufw allow 30333
ufw enable

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Set up Rust toolchains
echo "Setting up Rust toolchains..."
rustup default stable
rustup update
rustup update nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup target add wasm32-unknown-unknown --toolchain stable-x86_64-unknown-linux-gnu

# Handle potential Rust errors
echo "Adding Rust targets in case of errors..."
rustup target add wasm32-unknown-unknown --toolchain default || true
rustup component add rust-src --toolchain default || true

# Clone and build Ghostchain
echo "Cloning and building Ghostchain..."
mkdir -p ghost && cd ghost
git clone https://git.ghostchain.io/ghostchain/ghost-node.git
cd ghost-node
cargo build --release

# Download spec.json
echo "Downloading spec.json..."
wget -c https://ghostchain.io/wp-content/uploads/2024/09/spec.json -O ~/spec.json

echo "Installation and setup complete. Ghostchain node is ready!"
