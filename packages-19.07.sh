#!/usr/bin/env bash
# Collect the complete OpenWrt 19.07 feed using Git and an explicit source manifest.
set -Eeuo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
export OPENWRT_VERSION=19.07
export OPENWRT_SOURCES_FILE=${OPENWRT_SOURCES_FILE:-$script_dir/sources-19.07.tsv}
exec bash "$script_dir/scripts/generate-packages.sh" "$@"
