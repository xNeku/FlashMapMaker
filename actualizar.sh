#!/bin/bash
# Descarga la ultima build de FlashRacs para Mac, la instala en Aplicaciones y la abre.
set -e
# Se descarga del commit exacto: la cache de GitHub sirve copias viejas si se usa el nombre de la rama
REF="$(curl -fsSL -H "Accept: application/vnd.github.sha" https://api.github.com/repos/xNeku/FlashMapMaker/commits/descargas 2>/dev/null || true)"
[ ${#REF} -eq 40 ] || REF="descargas"
URL="https://github.com/xNeku/FlashMapMaker/raw/$REF/FlashRacs-mac.zip"
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
