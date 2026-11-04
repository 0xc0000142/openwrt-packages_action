#!/usr/bin/env bash
# Offline regression checks; never contact or publish to a remote repository.
set -Eeuo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
mkdir -p "$test_dir/bin" "$test_dir/tmp"
export TMPDIR="$test_dir/tmp"
export PATH="$test_dir/bin:$PATH"
export MOCK_GIT_LOG="$test_dir/git.log"
pinned_revision=2222222222222222222222222222222222222222

cat > "$test_dir/bin/git" <<'MOCK'
#!/usr/bin/env bash
set -euo pipefail

make_package() {
	local path=$1 identity=$2
	mkdir -p "$destination/$path/.github" "$destination/$path/.svn"
	printf '%s\n' 'include $(TOPDIR)/rules.mk' "PKG_NAME:=$identity" \
		'include $(INCLUDE_DIR)/package.mk' '$(eval $(call BuildPackage,$(PKG_NAME)))' > "$destination/$path/Makefile"
	printf 'fixture license\n' > "$destination/$path/LICENSE"
	printf 'fixture documentation\n' > "$destination/$path/README.md"
	printf 'unwanted metadata\n' > "$destination/$path/.github/test.yml"
}

populate() {
	case "$source_name" in
		primary)
			make_package . shared-engine
			make_package compat/luci-shared-config luci-shared-config
			;;
		collection)
			make_package bundle/suite-tunnel suite-tunnel
			make_package bundle/luci-suite luci-suite
			printf 'SUITE_VERSION:=1.2.3\n' > "$destination/bundle/version.mk"
			printf '%s\n' 'include ../version.mk' >> "$destination/bundle/suite-tunnel/Makefile"
			make_package packages/app-a app-a
			printf '%s\n' 'include ../../../luci.mk' >> "$destination/packages/app-a/Makefile"
			make_package packages/app-a/src internal-build-helper
			make_package packages/backend backend
				cat >> "$destination/packages/backend/Makefile" <<'GO_HELPER'
include ../../lang/golang/golang-package.mk
.PHONY: fixture-go-helper
fixture-go-helper:
	@printf '%s\n' '$(GOLANG_HELPER_LOADED)'
GO_HELPER
				make_package packages/easyconfig easyconfig
				cat >> "$destination/packages/easyconfig/Makefile" <<'EASYCONFIG'
PKG_VERSION:=$(shell printf '%s\n' 1704067200 | TZ=UTC awk '{print strftime("%Y%m%d", $1)}')
.PHONY: fixture-version
fixture-version:
	@printf '%s\n' '$(PKG_VERSION)'
EASYCONFIG
			make_package packages/normal-tool normal-tool
			make_package packages/suite-tunnel suite-tunnel
			make_package packages/duplicate-engine shared-engine
				make_package packages/variable-engine unused-identity
				sed -i '/^PKG_NAME/d' "$destination/packages/variable-engine/Makefile"
				printf '%s\n' 'NAME:=shared' 'PKG_NAME:=$(NAME)-engine' >> "$destination/packages/variable-engine/Makefile"
				make_package packages/explicit-engine unused-identity
				sed -i '/^PKG_NAME/d; /BuildPackage/d' "$destination/packages/explicit-engine/Makefile"
				printf '%s\n' '$(eval $(call BuildPackage,shared-engine))' >> "$destination/packages/explicit-engine/Makefile"
			make_package packages/luci-shared-config luci-shared-config
			make_package packages/base-files base-files
			make_package packages/firewall4 firewall4
			make_package packages/plugin-gargoyle-test plugin-gargoyle-test
			make_package outside-requested-tree unrelated-app
			if [[ ${MISSING_PACKAGE:-} == backend ]]; then rm "$destination/packages/backend/Makefile"; fi
			if [[ ${MISSING_TREE:-} == collection ]]; then rm -rf "$destination/packages"; fi
			;;
		mirror) make_package . shared-engine ;;
			legacy-snapshot) make_package legacy-app legacy-app ;;
			old-release) make_package . old-branch-app ;;
		empty-tree)
			mkdir -p "$destination/empty"
			printf 'all:\n\t@true\n' > "$destination/empty/Makefile"
			;;
		*) printf 'Unexpected mocked source: %s\n' "$source_name" >&2; exit 2 ;;
	esac
}

if [[ $1 == clone ]]; then
	[[ $# == 10 && $2 == --quiet && $3 == --depth && $4 == 1 && $5 == --single-branch && $6 == --branch && $8 == -- ]]
	destination=${10}
	source_name=${destination##*/}
	printf '%s\tclone\t%s\n' "$source_name" "$7" >> "$MOCK_GIT_LOG"
	[[ $source_name != "${FAIL_SOURCE:-}" ]] || exit 128
	mkdir -p "$destination/.git"
	printf '%s\n' 1111111111111111111111111111111111111111 > "$destination/.git/mock-revision"
	populate
elif [[ $1 == init ]]; then
	[[ $# == 3 && $2 == --quiet ]]
	mkdir -p "$3/.git"
elif [[ $1 == -C ]]; then
	destination=$2
	source_name=${destination##*/}
	case "$3" in
		remote)
			[[ $# == 6 && $4 == add && $5 == origin ]]
			printf '%s\n' "$6" > "$destination/.git/mock-origin"
			;;
		fetch)
			[[ $# == 8 && $4 == --quiet && $5 == --depth && $6 == 1 && $7 == origin && $8 =~ ^[0-9a-f]{40}$ ]]
			printf '%s\tfetch\t%s\n' "$source_name" "$8" >> "$MOCK_GIT_LOG"
			[[ $source_name != "${FAIL_SOURCE:-}" ]] || exit 128
			printf '%s\n' "$8" > "$destination/.git/mock-revision"
			;;
		checkout)
			[[ $# == 6 && $4 == --quiet && $5 == --detach && $6 == FETCH_HEAD ]]
			populate
			;;
		rev-parse)
			[[ $# == 4 && $4 == HEAD ]]
			cat "$destination/.git/mock-revision"
			;;
		*) printf 'Unexpected git operation: %s\n' "$3" >&2; exit 2 ;;
	esac
else
	printf 'Unexpected git invocation: %s\n' "$*" >&2
	exit 2
fi
MOCK
chmod +x "$test_dir/bin/git"

manifest="$test_dir/sources.tsv"
{
	printf '# source\turl\tref\tmode\tpath\tdestination\n'
	printf 'collection\thttps://example.invalid/collection.git\tmain\tbundle\tbundle\tsuite\n'
	printf 'primary\thttps://example.invalid/primary.git\tmain\tpackage\t.\tprimary-app\n'
	printf 'primary\thttps://example.invalid/primary.git\tmain\tpackage\t.\tprimary-again\n'
	printf 'collection\thttps://example.invalid/collection.git\tmain\ttree\tpackages\tcollection\n'
	printf 'collection\thttps://example.invalid/collection.git\tmain\tpackage\tpackages/backend\tbackend-copy\n'
	printf 'mirror\thttps://example.invalid/mirror.git\tmain\tpackage\t.\tother-engine\n'
	printf 'legacy-snapshot\thttps://example.invalid/legacy.git\t%s\tpackage\tlegacy-app\tlegacy-app\n' "$pinned_revision"
	printf 'old-release\thttps://example.invalid/old-release.git\topenwrt-21.02\tpackage\t.\told-branch-app\n'
} > "$manifest"
export OPENWRT_SOURCES_FILE="$manifest"

assert_empty() {
	[[ -z $(find "$1" -mindepth 1 -print -quit) ]]
}

expect_failure() {
	if "$@" > "$test_dir/failure.log" 2>&1; then
		printf 'Expected failure: %s\n' "$*" >&2
		exit 1
	fi
}

assert_migration() {
	local source=$1 destination=$2 status=$3
	awk -F '\t' -v source="$source" -v destination="$destination" -v status="$status" \
		'$1 == source && $3 == destination && $4 == status { found = 1 } END { exit !found }' "$output/MIGRATION.tsv"
}

# A small fixture exercises behavior independently of the real collection size.
output="$test_dir/generated feed"
bash "$repo_dir/packages-25.12.sh" "$output" > "$test_dir/success.log" 2>&1
for package in primary-app app-a backend normal-tool legacy-app; do
	[[ -f "$output/$package/Makefile" ]]
	case "$package" in
		primary-app) source=primary ;;
		legacy-app) source=legacy-snapshot ;;
		*) source=collection ;;
	esac
	assert_migration "$source" "$package" imported
done
[[ ! -e "$output/collection" && ! -e "$output/outside-requested-tree" ]]
[[ -f "$output/primary-app/LICENSE" && -f "$output/primary-app/README.md" ]]
[[ -z $(find "$output" \( -name .git -o -name .svn -o -name .github \) -print -quit) ]]
assert_empty "$TMPDIR"
printf 'PASS multi-package tree import, selected subtree and metadata cleanup\n'

# Parent recipes already contain their nested recipes and build helper sources.
[[ -f "$output/primary-app/compat/luci-shared-config/Makefile" ]]
[[ -f "$output/app-a/src/Makefile" ]]
for duplicate in primary-again duplicate-engine variable-engine explicit-engine other-engine backend-copy luci-shared-config src; do
	[[ ! -e "$output/$duplicate" ]]
done
assert_migration primary primary-again duplicate
assert_migration collection duplicate-engine duplicate
assert_migration collection variable-engine duplicate
assert_migration collection explicit-engine duplicate
assert_migration collection luci-shared-config duplicate
assert_migration collection backend-copy duplicate
assert_migration mirror other-engine duplicate
[[ $(awk -F '\t' '$1 == "primary-app" { count++ } END { print count + 0 }' "$output/PACKAGES.tsv") -eq 1 ]]
printf 'PASS literal, Make-variable and BuildPackage identities deduplicate nested recipes\n'

# Related recipes must keep shared parent files when a collection is flattened.
[[ ! -e "$output/suite/Makefile" ]]
[[ -f "$output/suite/suite-tunnel/Makefile" && -f "$output/suite/luci-suite/Makefile" ]]
[[ $(cat "$output/suite/version.mk") == 'SUITE_VERSION:=1.2.3' ]]
grep -Fxq 'include ../version.mk' "$output/suite/suite-tunnel/Makefile"
[[ ! -e "$output/suite-tunnel" ]]
assert_migration collection suite imported
assert_migration collection suite-tunnel duplicate
printf 'PASS bundles preserve shared makefiles and supersede flattened duplicates\n'

# Repeat manifest rows must reuse a fetched source and preserve an audit trail.
for source in primary collection mirror legacy-snapshot old-release; do
	[[ $(awk -F '\t' -v source="$source" '$1 == source { count++ } END { print count + 0 }' "$MOCK_GIT_LOG") -eq 1 ]]
	[[ $(awk -F '\t' -v source="$source" '$1 == source { count++ } END { print count + 0 }' "$output/SOURCES.lock") -eq 1 ]]
done
awk -F '\t' -v sha="$pinned_revision" '$1 == "legacy-snapshot" && $3 == sha && $4 == sha { found = 1 } END { exit !found }' "$output/SOURCES.lock"
awk -F '\t' '$1 == "legacy-app" && $4 == "legacy-fallback-needs-porting-review" { found = 1 } END { exit !found }' "$output/PACKAGES.tsv"
awk -F '\t' '$1 == "old-branch-app" && $4 == "legacy-fallback-needs-porting-review" { found = 1 } END { exit !found }' "$output/PACKAGES.tsv"
printf 'PASS source fetch deduplication, pinned revision lock and legacy review marker\n'

# Parse the relocated Go include and date expression with GNU Make itself.
# Empty OpenWrt stubs keep this independent of a firmware tree or toolchain.
build_root="$test_dir/build-root"
mkdir -p "$build_root/include" "$build_root/feeds/packages/lang/golang"
: > "$build_root/rules.mk"
: > "$build_root/include/package.mk"
printf 'GOLANG_HELPER_LOADED:=official-helper\n' > "$build_root/feeds/packages/lang/golang/golang-package.mk"
[[ $(make --no-print-directory -s -f "$output/backend/Makefile" \
	TOPDIR="$build_root" INCLUDE_DIR="$build_root/include" fixture-go-helper) == official-helper ]]
[[ $(make --no-print-directory -s -f "$output/easyconfig/Makefile" \
	TOPDIR="$build_root" INCLUDE_DIR="$build_root/include" fixture-version) == 20240101 ]]
assert_migration collection backend adapted
assert_migration collection easyconfig adapted
printf 'PASS relocated Go helpers load and easyconfig version expressions evaluate correctly\n'

# This is a literal Make variable, not a shell expansion.
# shellcheck disable=SC2016
grep -Fxq 'include $(TOPDIR)/feeds/luci/luci.mk' "$output/app-a/Makefile"
if grep -Eq 'include (\.\./)+luci\.mk' "$output/app-a/Makefile"; then
	printf 'Relative LuCI include was not normalized.\n' >&2
	exit 1
fi
for excluded in base-files firewall4 plugin-gargoyle-test; do
	[[ ! -e "$output/$excluded" ]]
	assert_migration collection "$excluded" excluded
done
printf 'PASS relative LuCI rules use the official feed and core exclusions are recorded\n'

# GitHub Actions invokes the script with no argument from an empty directory.
mkdir "$test_dir/default-output"
(cd "$test_dir/default-output" && bash "$repo_dir/packages-25.12.sh" > "$test_dir/default.log" 2>&1)
[[ -f "$test_dir/default-output/normal-tool/Makefile" ]]
assert_empty "$TMPDIR"
printf 'PASS default working-directory output\n'

# Both branch clones and late pinned-commit failures must leave output empty.
expect_failure env FAIL_SOURCE=collection bash "$repo_dir/packages-25.12.sh" "$test_dir/failed-clone"
assert_empty "$test_dir/failed-clone"
assert_empty "$TMPDIR"
expect_failure env FAIL_SOURCE=legacy-snapshot bash "$repo_dir/packages-25.12.sh" "$test_dir/failed-fetch"
assert_empty "$test_dir/failed-fetch"
assert_empty "$TMPDIR"
printf 'PASS clone and pinned-fetch failures keep the output empty\n'

# Explicit packages, selected trees and trees with no valid recipe are required.
expect_failure env MISSING_PACKAGE=backend bash "$repo_dir/packages-25.12.sh" "$test_dir/missing-package"
assert_empty "$test_dir/missing-package"
assert_empty "$TMPDIR"
expect_failure env MISSING_TREE=collection bash "$repo_dir/packages-25.12.sh" "$test_dir/missing-tree"
assert_empty "$test_dir/missing-tree"
assert_empty "$TMPDIR"
printf 'empty-tree\thttps://example.invalid/empty.git\tmain\ttree\tempty\tempty\n' > "$test_dir/empty.tsv"
expect_failure env OPENWRT_SOURCES_FILE="$test_dir/empty.tsv" bash "$repo_dir/packages-25.12.sh" "$test_dir/no-recipes"
assert_empty "$test_dir/no-recipes"
assert_empty "$TMPDIR"
printf 'PASS missing packages, changed directories and non-package trees reject the snapshot\n'

# Source IDs cannot silently point at different URLs or branches.
cp "$manifest" "$test_dir/conflict.tsv"
printf 'primary\thttps://example.invalid/other.git\tother\tpackage\t.\tconflicting\n' >> "$test_dir/conflict.tsv"
expect_failure env OPENWRT_SOURCES_FILE="$test_dir/conflict.tsv" bash "$repo_dir/packages-25.12.sh" "$test_dir/conflicting-source"
assert_empty "$test_dir/conflicting-source"
assert_empty "$TMPDIR"
printf 'PASS conflicting source specifications are rejected\n'

# Refuse destructive in-place runs, including directories with hidden files only.
mkdir "$test_dir/nonempty"
printf 'keep me\n' > "$test_dir/nonempty/.sentinel"
expect_failure bash "$repo_dir/packages-25.12.sh" "$test_dir/nonempty"
[[ $(cat "$test_dir/nonempty/.sentinel") == 'keep me' ]]
[[ $(find "$test_dir/nonempty" -mindepth 1 | wc -l) -eq 1 ]]
assert_empty "$TMPDIR"
expect_failure bash "$repo_dir/packages-25.12.sh" one two
printf 'PASS nonempty destination protection and invalid argument rejection\n'

# Guard the complete migration scope independently of the synthetic fixtures.
real_manifest="$repo_dir/sources-25.12.tsv"
coverage="$repo_dir/sources-25.12-coverage.tsv"
[[ -f "$real_manifest" && -f "$coverage" ]]
awk '/^[[:space:]]*git[[:space:]]+clone[[:space:]]/ { print NR }' \
	"$repo_dir/tests/fixtures/legacy-packages-21.02.sh.txt" > "$test_dir/expected-source-lines"
awk -F '\t' 'NR > 1 { print $1 }' "$coverage" | sort -n > "$test_dir/covered-source-lines"
diff -u "$test_dir/expected-source-lines" "$test_dir/covered-source-lines"
awk -F '\t' '
	FNR == NR {
		if ($1 !~ /^#/ && NF > 0) sources[$1] = 1
		next
	}
	FNR == 1 { next }
	NF != 6 || !($5 in sources) {
		printf "Unmapped original source at coverage line %d: %s\n", FNR, $0 > "/dev/stderr"
		invalid = 1
	}
	END { exit invalid }
' "$real_manifest" "$coverage"
for source in kenzok8__small-package Lienol__openwrt-package obsy__packages fw876__helloworld; do
	awk -F '\t' -v source="$source" \
		'$1 == source && $4 == "tree" && $5 == "." { found = 1 } END { exit !found }' "$real_manifest"
done
printf 'PASS every original clone line is covered and aggregate source trees are retained\n'
