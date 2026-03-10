#!/usr/bin/env bash
set -euo pipefail

REPO="zum281/ndoc"
INSTALL_DIR="${NDOC_INSTALL_DIR:-$HOME/.local/bin}"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

if command -v jq &>/dev/null; then
    VERSION=$(curl -fsSL "$API_URL" | jq -r '.tag_name' | sed 's/^v//')
else
    VERSION=$(curl -fsSL "$API_URL" | grep '"tag_name"' | cut -d'"' -f4 | sed 's/^v//')
fi

BASE_URL="https://github.com/${REPO}/releases/download/v${VERSION}"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL "${BASE_URL}/ndoc"        -o "$TMP_DIR/ndoc"
curl -fsSL "${BASE_URL}/ndoc.sha256" -o "$TMP_DIR/ndoc.sha256"

# Verify checksum (cross-platform: sha256sum on Linux, shasum on macOS)
if command -v sha256sum &>/dev/null; then
    (cd "$TMP_DIR" && sha256sum -c ndoc.sha256)
elif command -v shasum &>/dev/null; then
    (cd "$TMP_DIR" && shasum -a 256 -c ndoc.sha256)
else
    echo "Warning: no checksum tool found, skipping verification." >&2
fi

mkdir -p "$INSTALL_DIR"
if [[ -w "$INSTALL_DIR" ]]; then
    install -m 755 "$TMP_DIR/ndoc" "${INSTALL_DIR}/ndoc"
else
    sudo install -m 755 "$TMP_DIR/ndoc" "${INSTALL_DIR}/ndoc"
fi

echo "ndoc ${VERSION} installed to ${INSTALL_DIR}/ndoc"
