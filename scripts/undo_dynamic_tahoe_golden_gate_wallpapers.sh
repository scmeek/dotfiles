#!/usr/bin/env bash

# Extracted from the "To undo everything" section of:
# https://gist.github.com/pdfux/5659724021e584313c00b843312e909d

set -Eeuo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'error: this script only supports macOS\n' >&2
  exit 1
fi

if ! command -v defaults >/dev/null 2>&1; then
  printf 'error: defaults command not found\n' >&2
  exit 1
fi

: "${HOME:?error: HOME must be set}"

wallpaper_custom="$HOME/Library/Application Support/com.apple.wallpaper/aerials/custom"

delete_default() {
  local domain=$1
  local key=$2

  if defaults read "$domain" "$key" >/dev/null 2>&1; then
    defaults delete "$domain" "$key" >/dev/null
    printf 'Removed %s/%s\n' "$domain" "$key"
  else
    printf 'Already absent: %s/%s\n' "$domain" "$key"
  fi
}

delete_default com.apple.wallpaper.aerial AerialManifestLocalPathOverride

delete_default com.apple.wallpaper.aerial AerialManifestForceLocal

if [[ -e "$wallpaper_custom" || -L "$wallpaper_custom" ]]; then
  rm -rf -- "$wallpaper_custom"
  printf 'Removed %s\n' "$wallpaper_custom"
else
  printf 'Already absent: %s\n' "$wallpaper_custom"
fi

# Restart the wallpaper agents so they reload the normal catalog.
killall WallpaperAgent WallpaperAerialsExtension 2>/dev/null || true
printf 'Wallpaper agents restarted.\n'
