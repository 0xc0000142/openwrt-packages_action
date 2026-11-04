#!/usr/bin/env bash
# Collect the complete OpenWrt 18.06 feed using Git and an explicit source manifest.
set -Eeuo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
export OPENWRT_VERSION=18.06
export OPENWRT_SOURCES_FILE=${OPENWRT_SOURCES_FILE:-$script_dir/sources-18.06.tsv}
exec bash "$script_dir/scripts/generate-packages.sh" "$@"
