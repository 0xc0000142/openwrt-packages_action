#!/usr/bin/env bash
# Shared Git-based source collector; invoked by a version-specific entrypoint.
set -Eeuo pipefail
export LC_ALL=C
export GIT_TERMINAL_PROMPT=0

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

[[ $# -le 1 ]] || die "Usage: $0 [empty-output-directory]"
command -v git >/dev/null || die 'git is required'
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
version=${OPENWRT_VERSION:?Use a version-specific packages script}
case "$version" in 18.06|19.07|21.02|25.12) ;; *) die "Unsupported version: $version" ;; esac
sources_file=${OPENWRT_SOURCES_FILE:-$script_dir/sources-$version.tsv}
[[ -f "$sources_file" ]] || die "Missing source manifest: $sources_file"
output_dir=${1:-.}
mkdir -p -- "$output_dir"
output_dir=$(cd -- "$output_dir" && pwd -P)
[[ -z $(find "$output_dir" -mindepth 1 -maxdepth 1 -print -quit) ]] ||
	die "Output directory must be empty: $output_dir"

work_dir=$(mktemp -d)
trap 'rm -rf -- "$work_dir"' EXIT
trap 'printf "Source generation failed at line %s; publication must stop.\n" "$LINENO" >&2' ERR
mkdir -p "$work_dir/repos" "$work_dir/feed"
printf 'source\turl\tref\tcommit\n' > "$work_dir/feed/SOURCES.lock"
printf 'source\tpath\tdestination\tstatus\tdetail\n' > "$work_dir/feed/MIGRATION.tsv"
printf 'package\tsource\tpath\treview\n' > "$work_dir/feed/PACKAGES.tsv"
declare -A source_specs=() package_owners=() recipe_owners=()
package_count=0

record() {
	printf '%s\t%s\t%s\t%s\t%s\n' "$@" >> "$work_dir/feed/MIGRATION.tsv"
}

fetch_source() {
	local name=$1 url=$2 ref=$3 revision repo
	if [[ -n ${source_specs[$name]:-} ]]; then
		[[ ${source_specs[$name]} == "$url $ref" ]] || die "Conflicting source ID: $name"
		return
	fi
	repo="$work_dir/repos/$name"
	printf 'Fetching %s (%s)\n' "$name" "$ref"
	if [[ $ref =~ ^[0-9a-f]{40}$ ]]; then
		git init --quiet "$repo"
		git -C "$repo" remote add origin "$url"
		git -C "$repo" fetch --quiet --depth 1 origin "$ref"
		git -C "$repo" checkout --quiet --detach FETCH_HEAD
	else
		git clone --quiet --depth 1 --single-branch --branch "$ref" -- "$url" "$repo"
	fi
	revision=$(git -C "$repo" rev-parse HEAD)
	printf '%s\t%s\t%s\t%s\n' "$name" "$url" "$ref" "$revision" >> "$work_dir/feed/SOURCES.lock"
	source_specs[$name]="$url $ref"
}

is_recipe() {
	grep -Eq '^[[:space:]]*include[[:space:]].*/(rules|package|kernel|luci)\.mk|call[[:space:]]+(BuildPackage|KernelPackage)' "$1"
}

recipe_identity() {
	local value
	# Resolve simple Make variables without evaluating upstream make/shell code.
	value=$(awk '
		/^[A-Za-z_][A-Za-z0-9_]*[[:space:]]*[:?]?=/ {
			key=$0; sub(/[[:space:]]*[:?]?=.*/, "", key)
			value=$0; sub(/^[^=]*=[[:space:]]*/, "", value); sub(/[[:space:]#].*$/, "", value)
			vars[key]=value
		}
		END {
			value=vars["PKG_NAME"]
			for (i=0; i<10 && match(value, /\$\([A-Za-z_][A-Za-z0-9_]*\)/); i++) {
				key=substr(value, RSTART+2, RLENGTH-3)
				if (!(key in vars)) break
				value=substr(value,1,RSTART-1) vars[key] substr(value,RSTART+RLENGTH)
			}
			print value
		}' "$1")
	if [[ -z "$value" ]]; then
		value=$(sed -n 's/.*call BuildPackage,\([a-zA-Z0-9_.+-]*\)).*/\1/p' "$1")
		value=${value%%$'\n'*}
	fi
	if [[ $value =~ ^[a-zA-Z0-9_.+-]+$ ]]; then printf '%s' "$value"; else printf '%s' "$2"; fi
}

import_package() {
	local source=$1 path=$2 name=$3 bundle=${4:-false} source_dir target_dir identity review makefile nested
	source_dir="$work_dir/repos/$source/$path"
	target_dir="$work_dir/feed/$name"
	[[ $name =~ ^[a-zA-Z0-9_.+-]+$ && $name != . && $name != .. ]] || die "Invalid package directory: $name"
	if [[ $bundle == true ]]; then
		[[ -d "$source_dir" && -n $(find "$source_dir" -type f -name Makefile -print -quit) ]] || die "Missing bundled recipes: $source/$path"
		identity=$name
	else
		[[ -f "$source_dir/Makefile" ]] || die "Missing package Makefile: $source/$path"
		identity=$(recipe_identity "$source_dir/Makefile" "$name")
	fi
	# Keep the original script's exclusions for OpenWrt base-system packages.
	case "$name" in
		base-files|dnsmasq|firewall|firewall4|fullconenat|fullconenat-nft|libnftnl|nftables|opkg|ppp|wireless-regdb|plugin-gargoyle*)
			record "$source" "$path" "$name" excluded 'base-system/original exclusion'; return ;;
	esac
	if [[ -n ${package_owners[$name]:-} ]]; then
		record "$source" "$path" "$name" duplicate "selected ${package_owners[$name]}"; return
	fi
	if [[ -n ${recipe_owners[$identity]:-} ]]; then
		record "$source" "$path" "$name" duplicate "recipe $identity selected ${recipe_owners[$identity]}"; return
	fi
	cp -a -- "$source_dir" "$target_dir"
	if [[ $version == 25.12 && -f "$script_dir/packages-25.12-overrides/$name.mk" ]]; then
		cp -- "$script_dir/packages-25.12-overrides/$name.mk" "$target_dir/Makefile"
	fi
	# Flattened LuCI recipes must use the target tree's official LuCI rules.
	while IFS= read -r -d '' makefile; do
		# shellcheck disable=SC2016 # Preserve the literal OpenWrt make variable.
		sed -i -E 's@^([[:space:]]*include[[:space:]]+)(\.\./)+luci\.mk[[:space:]]*$@\1$(TOPDIR)/feeds/luci/luci.mk@' "$makefile"
		# shellcheck disable=SC2016 # Relocated Go recipes still use official helpers.
		sed -i -E 's@^([[:space:]]*include[[:space:]]+)(\.\./)+lang/golang/golang-package\.mk[[:space:]]*$@\1$(TOPDIR)/feeds/packages/lang/golang/golang-package.mk@' "$makefile"
	done < <(find "$target_dir" -type f -name Makefile -print0)
	if [[ $name == easyconfig ]]; then
		# Make consumes a single dollar before awk sees it; escape the field reference.
		# shellcheck disable=SC2016
		sed -i 's/strftime("%Y%m%d", \$1)/strftime("%Y%m%d", $$1)/' "$target_dir/Makefile"
	fi
	case "$version:$name" in
		25.12:luci-app-xray-geodata)
			sed -i 's/+xray-geodata/+v2ray-geoip +v2ray-geosite/g' "$target_dir/Makefile" ;;
		25.12:v2ray-geodata)
			# Preserve the official data aliases and paths with the Passwall provider.
			# shellcheck disable=SC2016 # These are literal OpenWrt Make variables.
			sed -i '/^define Package\/v2ray-geoip$/,/^endef$/ {
				/^endef$/i\
  PROVIDES+=@v2ray-geodata @xray-geodata @xray-geoip
			}
			/^define Package\/v2ray-geosite$/,/^endef$/ {
				/^endef$/i\
  PROVIDES+=@v2ray-geodata @xray-geodata @xray-geosite
			}
			/^define Package\/v2ray-geoip\/install$/,/^endef$/ {
				/^endef$/i\
\t$(INSTALL_DIR) $(1)/usr/share/xray\
\t$(LN) ../v2ray/geoip.dat $(1)/usr/share/xray/geoip.dat
			}
			/^define Package\/v2ray-geosite\/install$/,/^endef$/ {
				/^endef$/i\
\t$(INSTALL_DIR) $(1)/usr/share/xray\
\t$(LN) ../v2ray/geosite.dat $(1)/usr/share/xray/geosite.dat
			}' "$target_dir/Makefile" ;;
		25.12:luci-app-shadowsocks)
			sed -i 's@po2lmo/host@luci-base/host@g' "$target_dir/Makefile" ;;
		25.12:luci-app-dae|25.12:luci-app-daed)
			sed -i -E 's/\+daed?-(geoip|geosite)/+v2ray-\1/g' "$target_dir/Makefile" ;;
		25.12:qBittorrent-Enhanced-Edition)
			sed -i -E 's/\+qt5-(core|network|sql|xml)/+qt5base-\1/g; s/\bqttools\b/qt5tools/g' "$target_dir/Makefile" ;;
		25.12:luci-app-usb_printer)
			sed -i '/^[[:space:]]*select PACKAGE_printer-support[[:space:]]*$/d' "$target_dir/Makefile" ;;
	esac
	if [[ -f "$source_dir/Makefile" ]] && ! cmp -s "$source_dir/Makefile" "$target_dir/Makefile"; then
		record "$source" "$path" "$name" adapted "OpenWrt $version recipe/include/dependency fixes"
	fi
	package_owners[$name]="$source/$path"
	recipe_owners[$identity]="$source/$path"
	# A root recipe may bundle other recipes, such as Argon's config bridge.
	while IFS= read -r -d '' makefile; do
		if is_recipe "$makefile"; then
			nested=$(basename -- "$(dirname -- "$makefile")")
			recipe_owners[$(recipe_identity "$makefile" "$nested")]="$source/$path"
		fi
	done < <(find "$source_dir" -mindepth 2 -type f -name Makefile -not -path '*/.git/*' -print0)
	review=not-build-tested
	if [[ $source == legacy-* || ${source_specs[$source]} == *' openwrt-21.02' ]]; then
		review=legacy-fallback-needs-porting-review
	fi
	printf '%s\t%s\t%s\t%s\n' "$name" "$source" "$path" "$review" >> "$work_dir/feed/PACKAGES.tsv"
	record "$source" "$path" "$name" imported "$review"
	package_count=$((package_count + 1))
}

import_tree() {
	local source=$1 path=$2 root_name=$3 tree makefile relative name parent covered found=0
	local -a parents=()
	tree="$work_dir/repos/$source/$path"
	[[ -d "$tree" ]] || die "Missing source directory: $source/$path"
	# Parents sort before nested recipes, which are already included in the copy.
	while IFS= read -r -d '' makefile; do
		is_recipe "$makefile" || continue
		relative=${makefile#"$work_dir/repos/$source/"}
		relative=${relative%/Makefile}
		[[ $relative != Makefile ]] || relative=.
		covered=false
		for parent in "${parents[@]}"; do
			if [[ $parent == . || $relative == "$parent/"* ]]; then covered=true; break; fi
		done
		[[ $covered == false ]] || continue
		if [[ $relative == . || $relative == "$path" ]]; then name=$root_name; else name=${relative##*/}; fi
		import_package "$source" "$relative" "$name"
		parents+=("$relative")
		found=$((found + 1))
	done < <(find "$tree" -type f -name Makefile -not -path '*/.git/*' -print0 | sort -z)
	[[ $found -gt 0 ]] || die "No OpenWrt recipes in $source/$path"
}

import_file() {
	local source=$1 path=$2 destination=$3 target="$work_dir/feed/$3" name
	[[ -f "$work_dir/repos/$source/$path" ]] || die "Missing source file: $source/$path"
	if [[ -e "$target" ]]; then
		record "$source" "$path" "$destination" duplicate 'file already provided by an earlier source'
		return
	fi
	mkdir -p -- "$(dirname -- "$target")"
	cp -- "$work_dir/repos/$source/$path" "$target"
	record "$source" "$path" "$destination" imported 'standalone recipe or build helper'
	if [[ $destination == */Makefile ]]; then
		name=${destination%/Makefile}
		package_owners[$name]="$source/$path"
		printf '%s\t%s\t%s\tnot-build-tested\n' "$name" "$source" "$path" >> "$work_dir/feed/PACKAGES.tsv"
		package_count=$((package_count + 1))
	fi
}

preserve_archive() {
	local source=$1 path=$2 name=$3
	[[ -d "$work_dir/repos/$source/$path" ]] || die "Missing source archive: $source/$path"
	if [[ -e "$work_dir/feed/$name" ]]; then
		record "$source" "$path" "$name" duplicate 'directory already provided by an earlier source'
		return
	fi
	cp -a -- "$work_dir/repos/$source/$path" "$work_dir/feed/$name"
	record "$source" "$path" "$name" preserved 'source archive without an OpenWrt recipe; not buildable as a feed package'
}

# Manifest order defines precedence; every duplicate or exclusion is recorded.
while IFS=$'\t' read -r source url ref mode path destination extra; do
	[[ -n "$source" && $source != \#* ]] || continue
	[[ -z ${extra:-} && -n "$destination" && $source =~ ^[a-zA-Z0-9_.+-]+$ ]] || die "Invalid manifest row: $source"
	if [[ $mode == file ]]; then
		[[ $destination =~ ^[a-zA-Z0-9_.+-]+(/[a-zA-Z0-9_.+-]+)*$ && /$destination/ != */../* && /$destination/ != */./* && /$destination/ != */.git/* ]] || die "Unsafe file destination: $destination"
	else
		[[ $destination =~ ^[a-zA-Z0-9_.+-]+$ && $destination != . && $destination != .. ]] || die "Invalid destination: $destination"
	fi
	[[ $path != /* && $path != .. && $path != ../* && $path != */../* && $path != */.. ]] || die "Unsafe package path: $path"
	fetch_source "$source" "$url" "$ref"
	case "$mode" in
		package) import_package "$source" "$path" "$destination" ;;
		bundle) import_package "$source" "$path" "$destination" true ;;
		tree) import_tree "$source" "$path" "$destination" ;;
		file) import_file "$source" "$path" "$destination" ;;
		archive) preserve_archive "$source" "$path" "$destination" ;;
		*) die "Unknown import mode: $mode" ;;
	esac
done < "$sources_file"

[[ $package_count -gt 0 ]] || die 'No packages were imported'
find "$work_dir/feed" \( -name .git -o -name .svn -o -name .github \) -prune -exec rm -rf -- {} +
cp -a -- "$work_dir/feed/." "$output_dir/"
printf 'Generated %s package directories for OpenWrt %s in %s\n' "$package_count" "$version" "$output_dir"
