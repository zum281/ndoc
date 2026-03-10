#!/usr/bin/env bash
set -euo pipefail

REPO="zum281/ndoc"
INSTALL_DIR="${NDOC_INSTALL_DIR:-/usr/local/bin}"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

if command -v jq &>/dev/null; then
    VERSION=$(curl -fsSL "$API_URL" | jq -r '.tag_name' | sed 's/^v//')
else
    VERSION=$(curl -fsSL "$API_URL" | grep '"tag_name"' | cut -d'"' -f4 | sed 's/^v//')
fi

BASE_URL="https://github.com/${REPO}/releases/download/v${VERSION}"

TMP_SCRIPT=$(mktemp)
TMP_SUM=$(mktemp)
trap 'rm -f "$TMP_SCRIPT" "$TMP_SUM"' EXIT

curl -fsSL "${BASE_URL}/ndoc"       -o "$TMP_SCRIPT"
curl -fsSL "${BASE_URL}/ndoc.sha256" -o "$TMP_SUM"

# Verify checksum (cross-platform: sha256sum on Linux, shasum on macOS)
if command -v sha256sum &>/dev/null; then
    (cd "$(dirname "$TMP_SCRIPT")" && sha256sum -c "$TMP_SUM")
elif command -v shasum &>/dev/null; then
    (cd "$(dirname "$TMP_SCRIPT")" && shasum -a 256 -c "$TMP_SUM")
else
    echo "Warning: no checksum tool found, skipping verification." >&2
fi

if [[ -w "$INSTALL_DIR" ]]; then
    install -m 755 "$TMP_SCRIPT" "${INSTALL_DIR}/ndoc"
else
    sudo install -m 755 "$TMP_SCRIPT" "${INSTALL_DIR}/ndoc"
fi

echo "ndoc ${VERSION} installed to ${INSTALL_DIR}/ndoc"
