#!/bin/bash
# Descarga la ultima build de FlashRacs para Mac, la instala en Aplicaciones y la abre.
set -e
URL="https://github.com/xNeku/FlashMapMaker/raw/descargas/FlashRacs-mac.zip?t=$(date +%s)"
TMP="$(mktemp -d)"
echo "Descargando FlashRacs..."
curl -fL --progress-bar -o "$TMP/FlashRacs-mac.zip" "$URL"
unzip -q -o "$TMP/FlashRacs-mac.zip" -d "$TMP/x"
pkill -x FlashRacs 2>/dev/null || true
sleep 1
rm -rf /Applications/FlashRacs.app
mv "$TMP/x/FlashRacs.app" /Applications/
xattr -cr /Applications/FlashRacs.app
rm -rf "$TMP"
echo "Listo. Abriendo FlashRacs..."
open /Applications/FlashRacs.app
