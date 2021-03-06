#!/usr/bin/env bash
set -e

dir=packed
arch="$(node -p process.arch)"
tag="$(git describe --tags)"

mkdir -p "${dir}"

pkg bin/nightscout-ps1-daemon.js \
  --config package.json \
  --output "${dir}/nightscout-ps1-daemon-v${tag}" \
  -t node9-alpine,node9-linux,node9-macos,node9-win

for fullpath in "${dir}"/*; do
  ext=""
  if [ "${fullpath: -4}" = ".exe" ]; then
    ext=".exe"
  fi

  dest="${dir}/$(basename "${fullpath}" "${ext}")-${arch}${ext}"

  mv -v "${fullpath}" "${dest}"
done
