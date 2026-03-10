# ndoc

Browse Node.js API documentation from your terminal.

## Requirements

- `curl` (required)
- [`glow`](https://github.com/charmbracelet/glow) or [`bat`](https://github.com/sharkdp/bat) (optional, for better rendering)
- `jq` (optional, for reliable `--list` output)

## Installation

```sh
curl -o /usr/local/bin/ndoc https://raw.githubusercontent.com/fulviamourikis/ndoc/main/ndoc
chmod +x /usr/local/bin/ndoc
```

Or clone the repo and symlink:

```sh
git clone https://github.com/fulviamourikis/ndoc.git
ln -s "$PWD/ndoc/ndoc" /usr/local/bin/ndoc
```

## Usage

```sh
ndoc fs                  # Full fs module docs
ndoc fs.readFile         # Only the readFile section
ndoc --list              # List all available modules
ndoc --help              # Show help
```

## How it works

Fetches Markdown source directly from the [Node.js GitHub repository](https://github.com/nodejs/node/tree/main/doc/api) and renders it in your terminal via `glow`, `bat`, or `less`.

## License

MIT
