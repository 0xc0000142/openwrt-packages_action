#!/usr/bin/env bash
# Collect the complete OpenWrt 21.02 feed using Git and an explicit source manifest.
set -Eeuo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
export OPENWRT_VERSION=21.02
export OPENWRT_SOURCES_FILE=${OPENWRT_SOURCES_FILE:-$script_dir/sources-21.02.tsv}
exec bash "$script_dir/scripts/generate-packages.sh" "$@"
