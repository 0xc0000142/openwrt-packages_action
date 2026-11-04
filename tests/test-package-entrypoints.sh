#!/usr/bin/env bash
# Exercise all public entrypoints against a local Git fixture; no network access.
set -Eeuo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
fixture_repo="$test_dir/fixture-repo"
source_repo="$test_dir/source-repo"
mkdir -p "$fixture_repo/scripts" "$fixture_repo/packages-25.12-overrides" \
	"$source_repo/luci-app-shadowsocks" "$source_repo/override-probe" \
	"$source_repo/raw-theme/.github" "$test_dir/tmp" "$test_dir/bin"
export TMPDIR="$test_dir/tmp"
export PATH="$test_dir/bin:$PATH"
cat > "$test_dir/bin/wget" <<'NO_WGET'
#!/usr/bin/env bash
printf 'Unexpected wget invocation; standalone files must come from Git.\n' >&2
exit 1
NO_WGET
chmod +x "$test_dir/bin/wget"
cp "$repo_dir/scripts/generate-packages.sh" "$fixture_repo/scripts/"
cp "$repo_dir/packages.sh" "$repo_dir/packages-19.07.sh" \
	"$repo_dir/packages-21.02.sh" "$repo_dir/packages-25.12.sh" "$fixture_repo/"

cat > "$source_repo/luci-app-shadowsocks/Makefile" <<'MAKEFILE'
include $(TOPDIR)/rules.mk
PKG_NAME:=luci-app-shadowsocks
PKG_BUILD_DEPENDS:=po2lmo/host
include ../../luci.mk
MAKEFILE
cat > "$source_repo/override-probe/Makefile" <<'MAKEFILE'
include $(TOPDIR)/rules.mk
PKG_NAME:=override-probe
# upstream recipe
include $(INCLUDE_DIR)/package.mk
MAKEFILE
cat > "$fixture_repo/packages-25.12-overrides/override-probe.mk" <<'MAKEFILE'
include $(TOPDIR)/rules.mk
PKG_NAME:=override-probe
# version-specific override
include $(INCLUDE_DIR)/package.mk
MAKEFILE
cat > "$source_repo/Parted.Makefile" <<'MAKEFILE'
include $(TOPDIR)/rules.mk
PKG_NAME:=parted
include $(INCLUDE_DIR)/package.mk
MAKEFILE
printf '# shared LuCI fixture rules\n' > "$source_repo/luci.mk"
printf 'theme payload\n' > "$source_repo/raw-theme/theme.js"
printf 'theme license\n' > "$source_repo/raw-theme/LICENSE"
printf 'unwanted repository metadata\n' > "$source_repo/raw-theme/.github/config.yml"

git init --quiet --initial-branch=main "$source_repo"
git -C "$source_repo" -c user.name=fixture -c user.email=fixture@example.invalid add .
git -C "$source_repo" -c user.name=fixture -c user.email=fixture@example.invalid commit --quiet -m fixture

for version in 18.06 19.07 21.02 25.12; do
	{
		printf 'fixture-%s\t%s\tmain\ttree\t.\tfixture-root\n' "$version" "$source_repo"
		printf 'fixture-%s\t%s\tmain\tfile\tParted.Makefile\tparted/Makefile\n' "$version" "$source_repo"
		printf 'fixture-%s\t%s\tmain\tfile\tluci.mk\tluci.mk\n' "$version" "$source_repo"
		printf 'fixture-%s\t%s\tmain\tarchive\traw-theme\traw-theme\n' "$version" "$source_repo"
	} > "$fixture_repo/sources-${version}.tsv"
	if [[ $version == 18.06 ]]; then wrapper=packages.sh; else wrapper="packages-${version}.sh"; fi
	output="$test_dir/feed-${version}"
	# A caller's unrelated version setting cannot change this entrypoint's target.
	env -u OPENWRT_SOURCES_FILE OPENWRT_VERSION=invalid bash "$fixture_repo/$wrapper" "$output" \
		> "$test_dir/${version}.log" 2>&1
	[[ -f "$output/luci-app-shadowsocks/Makefile" && -f "$output/override-probe/Makefile" ]]
	cmp "$source_repo/Parted.Makefile" "$output/parted/Makefile"
	cmp "$source_repo/luci.mk" "$output/luci.mk"
	cmp "$source_repo/raw-theme/theme.js" "$output/raw-theme/theme.js"
	cmp "$source_repo/raw-theme/LICENSE" "$output/raw-theme/LICENSE"
	[[ ! -e "$output/raw-theme/.github" && ! -e "$output/raw-theme/Makefile" ]]
	awk -F '\t' '$1 == "raw-theme" { found = 1 } END { exit found }' "$output/PACKAGES.tsv"
	awk -F '\t' '$3 == "raw-theme" && $4 == "preserved" && $5 ~ /not buildable/ { found = 1 } END { exit !found }' "$output/MIGRATION.tsv"
	awk -F '\t' '$3 == "parted/Makefile" && $4 == "imported" { found = 1 } END { exit !found }' "$output/MIGRATION.tsv"
	awk -F '\t' -v source="fixture-${version}" \
		'$1 == source { found = 1 } END { exit !found }' "$output/SOURCES.lock"
	# Path relocation is required in both historical and current feeds.
	# shellcheck disable=SC2016
	grep -Fxq 'include $(TOPDIR)/feeds/luci/luci.mk' "$output/luci-app-shadowsocks/Makefile"
	if [[ $version == 25.12 ]]; then
		grep -Fxq 'PKG_BUILD_DEPENDS:=luci-base/host' "$output/luci-app-shadowsocks/Makefile"
		grep -Fxq '# version-specific override' "$output/override-probe/Makefile"
	else
		grep -Fxq 'PKG_BUILD_DEPENDS:=po2lmo/host' "$output/luci-app-shadowsocks/Makefile"
		grep -Fxq '# upstream recipe' "$output/override-probe/Makefile"
	fi
	printf 'PASS %s selects its manifest and isolates version-specific adaptations\n' "$wrapper"

	# An explicit manifest must remain usable from an arbitrary empty working dir.
	custom_manifest="$test_dir/custom-${version}.tsv"
	printf 'custom-%s\t%s\tmain\tpackage\toverride-probe\tselected-package\n' "$version" "$source_repo" \
		> "$custom_manifest"
	mkdir "$test_dir/cwd-${version}"
	(cd "$test_dir/cwd-${version}" && OPENWRT_SOURCES_FILE="$custom_manifest" \
		bash "$fixture_repo/$wrapper" > "$test_dir/custom-${version}.log" 2>&1)
	[[ -f "$test_dir/cwd-${version}/selected-package/Makefile" ]]
	[[ ! -e "$test_dir/cwd-${version}/luci-app-shadowsocks" ]]

	# The wrapper must propagate generation failures and preserve output emptiness.
	printf 'broken\t%s\tmain\tpackage\tmissing-package\tmissing-package\n' "$source_repo" \
		> "$test_dir/broken-${version}.tsv"
	if OPENWRT_SOURCES_FILE="$test_dir/broken-${version}.tsv" \
		bash "$fixture_repo/$wrapper" "$test_dir/failed-${version}" > "$test_dir/failed-${version}.log" 2>&1; then
		printf '%s accepted a missing package.\n' "$wrapper" >&2
		exit 1
	fi
	[[ -z $(find "$test_dir/failed-${version}" -mindepth 1 -print -quit) ]]
	# A late standalone-file failure must discard packages imported beforehand.
	cp "$fixture_repo/sources-${version}.tsv" "$test_dir/missing-file-${version}.tsv"
	printf 'fixture-%s\t%s\tmain\tfile\tmissing.mk\tmissing.mk\n' "$version" "$source_repo" \
		>> "$test_dir/missing-file-${version}.tsv"
	if OPENWRT_SOURCES_FILE="$test_dir/missing-file-${version}.tsv" \
		bash "$fixture_repo/$wrapper" "$test_dir/failed-file-${version}" > "$test_dir/failed-file-${version}.log" 2>&1; then
		printf '%s accepted a missing standalone file.\n' "$wrapper" >&2
		exit 1
	fi
	[[ -z $(find "$test_dir/failed-file-${version}" -mindepth 1 -print -quit) ]]
	cp "$fixture_repo/sources-${version}.tsv" "$test_dir/missing-archive-${version}.tsv"
	printf 'fixture-%s\t%s\tmain\tarchive\tmissing-theme\tmissing-theme\n' "$version" "$source_repo" \
		>> "$test_dir/missing-archive-${version}.tsv"
	if OPENWRT_SOURCES_FILE="$test_dir/missing-archive-${version}.tsv" \
		bash "$fixture_repo/$wrapper" "$test_dir/failed-archive-${version}" > "$test_dir/failed-archive-${version}.log" 2>&1; then
		printf '%s accepted a missing source archive.\n' "$wrapper" >&2
		exit 1
	fi
	[[ -z $(find "$test_dir/failed-archive-${version}" -mindepth 1 -print -quit) ]]
	[[ -z $(find "$TMPDIR" -mindepth 1 -print -quit) ]]
done
printf 'PASS all entrypoints preserve Git-sourced helpers and propagate package/file/archive failures\n'
printf 'PASS all entrypoints accept manifest overrides and the default working directory\n'

printf 'archive-only\t%s\tmain\tarchive\traw-theme\traw-theme\n' "$source_repo" > "$test_dir/archive-only.tsv"
if OPENWRT_SOURCES_FILE="$test_dir/archive-only.tsv" bash "$fixture_repo/packages-19.07.sh" \
	"$test_dir/archive-only" > "$test_dir/archive-only.log" 2>&1; then
	printf 'An archive without package recipes was counted as a generated feed.\n' >&2
	exit 1
fi
[[ -z $(find "$test_dir/archive-only" -mindepth 1 -print -quit) ]]
printf 'PASS non-buildable archives retain source content without counting as feed packages\n'

# Exercise the real Xray manifest mapping against a local multi-package source.
for path in core geodata status; do
	case "$path" in
		core) package=luci-app-xray ;;
		*) package="luci-app-xray-$path" ;;
	esac
	mkdir -p "$source_repo/$path/root"
	# shellcheck disable=SC2016 # The fixture must contain literal Make variables.
	printf '%s\n' 'include $(TOPDIR)/rules.mk' "PKG_NAME:=$package" \
		'include $(INCLUDE_DIR)/package.mk' > "$source_repo/$path/Makefile"
	printf '%s\n' "$package payload" > "$source_repo/$path/root/payload"
done
cat >> "$source_repo/geodata/Makefile" <<'MAKEFILE'
define Package/luci-app-xray-geodata
  DEPENDS:=luci-app-xray +xray-geodata
endef
MAKEFILE
mkdir "$source_repo/v2ray-geodata"
cat > "$source_repo/v2ray-geodata/Makefile" <<'MAKEFILE'
include $(TOPDIR)/rules.mk
PKG_NAME:=v2ray-geodata
include $(INCLUDE_DIR)/package.mk
define Package/v2ray-geoip
  TITLE:=GeoIP List
endef
define Package/v2ray-geosite
  TITLE:=Geosite List
endef
define Package/v2ray-geoip/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray
	printf 'geoip payload\n' > $(1)/usr/share/v2ray/geoip.dat
endef
define Package/v2ray-geosite/install
	$(INSTALL_DIR) $(1)/usr/share/v2ray
	printf 'geosite payload\n' > $(1)/usr/share/v2ray/geosite.dat
endef
MAKEFILE
printf 'Xray fixture license\n' > "$source_repo/LICENSE"
git -C "$source_repo" add .
git -C "$source_repo" -c user.name=fixture -c user.email=fixture@example.invalid commit --quiet -m 'Xray subpackages'
awk -F '\t' -v OFS='\t' -v url="$source_repo" \
	'$1 == "yichya__luci-app-xray" { $2=url; $3="main"; print }' \
	"$repo_dir/sources-25.12.tsv" > "$test_dir/xray.tsv"
printf 'fixture-geodata\t%s\tmain\tpackage\tv2ray-geodata\tv2ray-geodata\n' "$source_repo" \
	>> "$test_dir/xray.tsv"
OPENWRT_SOURCES_FILE="$test_dir/xray.tsv" bash "$fixture_repo/packages-25.12.sh" \
	"$test_dir/xray-feed" > "$test_dir/xray.log" 2>&1
for package in luci-app-xray luci-app-xray-geodata luci-app-xray-status; do
	[[ -f "$test_dir/xray-feed/$package/Makefile" ]]
	grep -Fxq "$package payload" "$test_dir/xray-feed/$package/root/payload"
	cmp "$source_repo/LICENSE" "$test_dir/xray-feed/$package/LICENSE"
done
[[ ! -e "$test_dir/xray-feed/core" && ! -e "$test_dir/xray-feed/geodata" && ! -e "$test_dir/xray-feed/status" ]]

# Execute the generated data install rules: Xray must see both actual assets,
# and the links must belong to their data packages, not the LuCI interface.
mkdir "$test_dir/make-stubs"
touch "$test_dir/make-stubs/rules.mk" "$test_dir/make-stubs/package.mk"
cat > "$test_dir/install-geodata.mk" <<'MAKEFILE'
include $(FEED)/luci-app-xray-geodata/Makefile
$(eval $(Package/luci-app-xray-geodata))
include $(FEED)/v2ray-geodata/Makefile
$(eval $(Package/v2ray-geoip))
geoip_provides := $(PROVIDES)
PROVIDES :=
$(eval $(Package/v2ray-geosite))
INSTALL_DIR := mkdir -p
LN := ln -sf
.PHONY: check
check:
	test "$(DEPENDS)" = 'luci-app-xray +v2ray-geoip +v2ray-geosite'
	test "$(filter @xray-geodata @xray-geoip,$(geoip_provides))" = '@xray-geodata @xray-geoip'
	test "$(filter @xray-geodata @xray-geosite,$(PROVIDES))" = '@xray-geodata @xray-geosite'
	$(call Package/v2ray-geoip/install,$(DESTDIR))
	$(call Package/v2ray-geosite/install,$(DESTDIR))
MAKEFILE
make --no-print-directory -f "$test_dir/install-geodata.mk" check \
	TOPDIR="$test_dir/make-stubs" INCLUDE_DIR="$test_dir/make-stubs" \
	FEED="$test_dir/xray-feed" DESTDIR="$test_dir/xray-root" > "$test_dir/xray-install.log" 2>&1
for asset in geoip geosite; do
	[[ $(readlink "$test_dir/xray-root/usr/share/xray/$asset.dat") == "../v2ray/$asset.dat" ]]
	grep -Fxq "$asset payload" "$test_dir/xray-root/usr/share/xray/$asset.dat"
done
OPENWRT_SOURCES_FILE="$test_dir/xray.tsv" bash "$fixture_repo/packages-21.02.sh" \
	"$test_dir/xray-legacy-feed" > "$test_dir/xray-legacy.log" 2>&1
cmp "$source_repo/v2ray-geodata/Makefile" "$test_dir/xray-legacy-feed/v2ray-geodata/Makefile"
cmp "$source_repo/geodata/Makefile" "$test_dir/xray-legacy-feed/luci-app-xray-geodata/Makefile"
printf 'PASS Xray packages retain names, payload and license; 25.12 resolves both data assets\n'

# Every historical download must have a recorded destination in the new source
# manifests, including SVN subtree imports and standalone wget recipes.
for version in 18.06 19.07 21.02; do
	baseline="$repo_dir/tests/fixtures/legacy-packages-${version}.sh.txt"
	manifest="$repo_dir/sources-${version}.tsv"
	coverage="$repo_dir/sources-${version}-coverage.tsv"
	[[ -f "$baseline" && -f "$manifest" && -f "$coverage" ]]
	awk '/^[[:space:]]*(git[[:space:]]+clone|svn[[:space:]]+(co|export)|wget[[:space:]])/ { print NR }' \
		"$baseline" > "$test_dir/download-lines-${version}"
	awk -F '\t' 'NR > 1 { print $1 }' "$coverage" | sort -n > "$test_dir/coverage-lines-${version}"
	diff -u "$test_dir/download-lines-${version}" "$test_dir/coverage-lines-${version}"
	awk -F '\t' '
		FNR == NR {
			if ($1 !~ /^#/ && NF > 0) sources[$1] = 1
			next
		}
		FNR == 1 {
			for (column = 1; column <= NF; column++) if ($column == "source") source_column = column
			if (!source_column) { invalid = 1; exit }
			next
		}
		!($source_column in sources) {
			printf "Unmapped historical download at coverage line %d: %s\n", FNR, $0 > "/dev/stderr"
			invalid = 1
		}
		END { exit invalid }
	' "$manifest" "$coverage"
done
printf 'PASS all historical Git, SVN and standalone-file downloads have manifest mappings\n'
