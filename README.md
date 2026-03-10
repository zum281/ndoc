# ndoc

![version](https://img.shields.io/github/v/release/zum281/ndoc)

Browse Node.js API documentation from your terminal.

## Requirements

- `curl` (required)
- [`glow`](https://github.com/charmbracelet/glow) or [`bat`](https://github.com/sharkdp/bat) (optional, for better rendering)
- `jq` (optional, for reliable `--list` output)

## Installation

### Install script (recommended)

```sh
curl -fsSL https://raw.githubusercontent.com/zum281/ndoc/main/install.sh | bash
```

Downloads the latest release and verifies its SHA-256 checksum before installing. Installs to `/usr/local/bin` by default — override with `NDOC_INSTALL_DIR`:

```sh
NDOC_INSTALL_DIR=~/.local/bin curl -fsSL https://raw.githubusercontent.com/zum281/ndoc/main/install.sh | bash
```

### Manual (specific version)

```sh
VERSION=1.0.0
curl -fsSL "https://github.com/zum281/ndoc/releases/download/v${VERSION}/ndoc" \
  -o /usr/local/bin/ndoc
chmod +x /usr/local/bin/ndoc
```

### From source

```sh
git clone https://github.com/zum281/ndoc.git
ln -s "$PWD/ndoc/ndoc" /usr/local/bin/ndoc
```

## Usage

```sh
ndoc fs                  # Full fs module docs
ndoc fs.readFile         # Only the readFile section
ndoc --list              # List all available modules
ndoc --version           # Show ndoc version
ndoc --help              # Show help
```

## How it works

Fetches Markdown source directly from the [Node.js GitHub repository](https://github.com/nodejs/node/tree/main/doc/api) and renders it in your terminal via `glow`, `bat`, or `less`.

## License

MIT
