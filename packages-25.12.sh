#!/usr/bin/env bash
# Collect the complete OpenWrt 25.12 feed using Git and an explicit source manifest.
set -Eeuo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
export OPENWRT_VERSION=25.12
export OPENWRT_SOURCES_FILE=${OPENWRT_SOURCES_FILE:-$script_dir/sources-25.12.tsv}
exec bash "$script_dir/scripts/generate-packages.sh" "$@"
