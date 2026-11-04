#!/usr/bin/env bash
# Exercise the workflow's actual publication script against a local bare remote.
set -Eeuo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
export GIT_ALLOW_PROTOCOL=file
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_NOSYSTEM=1
export GIT_TERMINAL_PROMPT=0
export TARGET=packages-25.12
export RUNNER_TEMP="$test_dir/runner"
export STAGING="$test_dir/staging"
checkout="$test_dir/checkout"
remote="$test_dir/remote.git"
mkdir -p "$RUNNER_TEMP" "$STAGING" "$checkout/package/src"

# Extract the current YAML run block rather than duplicating the implementation.
awk '
	/^      - name: Publish the completed package snapshot$/ { selected = 1; next }
	selected && /^        run: \|$/ { body = 1; next }
	body && /^      - / { exit }
	body { sub(/^          /, ""); print }
' "$repo_dir/.github/workflows/update-packages.yml" > "$test_dir/publish.sh"
[[ -s "$test_dir/publish.sh" ]]
bash -n "$test_dir/publish.sh"

git init --bare --quiet --initial-branch=master "$remote"
git init --quiet --initial-branch=master "$checkout"
git -C "$checkout" config user.name fixture
git -C "$checkout" config user.email fixture@example.invalid
printf '# fixture package\n' > "$checkout/package/Makefile"
printf '*.sh\n' > "$checkout/package/.gitignore"
printf '#!/bin/sh\nprintf "required runtime helper\\n"\n' > "$checkout/package/src/ignored.sh"
printf 'old hidden content\n' > "$checkout/.obsolete"
printf 'fixture license\n' > "$checkout/LICENSE"
printf 'fixture readme\n' > "$checkout/README.md"
# Upstreams can track files even when their .gitignore also matches those files.
git -C "$checkout" add --all --force
git -C "$checkout" commit --quiet -m 'tracked source fixture'
git -C "$checkout" remote add origin "$remote"
git -C "$checkout" push --quiet origin master
git -C "$checkout" archive HEAD | tar -x -C "$STAGING"
source_blob=$(git -C "$checkout" rev-parse HEAD:package/src/ignored.sh)

run_publish() {
	(cd "$checkout" && bash -eo pipefail "$test_dir/publish.sh") > "$test_dir/publish.log" 2>&1
}

run_publish
first=$(git --git-dir="$remote" rev-parse "refs/heads/$TARGET")
[[ $(git --git-dir="$remote" rev-parse "$first:package/src/ignored.sh") == "$source_blob" ]]
[[ $(git --git-dir="$remote" rev-list --count "$first") -eq 1 ]]
printf 'PASS first publication creates the branch and retains tracked files matched by .gitignore\n'

rm "$STAGING/.obsolete"
printf 'new hidden content\n' > "$STAGING/.current"
printf '# updated package\n' > "$STAGING/package/Makefile"
run_publish
second=$(git --git-dir="$remote" rev-parse "refs/heads/$TARGET")
[[ "$second" != "$first" ]]
git --git-dir="$remote" merge-base --is-ancestor "$first" "$second"
if git --git-dir="$remote" cat-file -e "$second:.obsolete" 2>/dev/null; then
	printf 'Publication retained a stale hidden file.\n' >&2
	exit 1
fi
git --git-dir="$remote" cat-file -e "$second:.current"
[[ $(git --git-dir="$remote" rev-parse "$second:package/src/ignored.sh") == "$source_blob" ]]
printf 'PASS existing branches update normally and remove stale hidden files\n'

run_publish
[[ $(git --git-dir="$remote" rev-parse "refs/heads/$TARGET") == "$second" ]]
printf 'PASS unchanged snapshots succeed without creating a commit\n'

# Advance the remote after the workflow fetches, immediately before its push.
# A force push would overwrite this competing commit and make this test fail.
mkdir "$test_dir/bin"
export REAL_GIT
REAL_GIT=$(command -v git)
export PUBLISH_RACE_REMOTE="$remote"
export PUBLISH_RACE_COMMIT_FILE="$test_dir/race-commit"
cat > "$test_dir/bin/git" <<'GIT_RACE'
#!/usr/bin/env bash
set -euo pipefail
original_args=("$@")
if [[ ${1:-} == -C ]]; then shift 2; fi
if [[ ${1:-} == push ]]; then
	previous=$("$REAL_GIT" --git-dir="$PUBLISH_RACE_REMOTE" rev-parse "refs/heads/$TARGET")
	tree=$("$REAL_GIT" --git-dir="$PUBLISH_RACE_REMOTE" rev-parse "$previous^{tree}")
	competing=$(printf 'competing publication\n' | "$REAL_GIT" --git-dir="$PUBLISH_RACE_REMOTE" \
		-c user.name=fixture -c user.email=fixture@example.invalid commit-tree "$tree" -p "$previous")
	"$REAL_GIT" --git-dir="$PUBLISH_RACE_REMOTE" update-ref "refs/heads/$TARGET" "$competing" "$previous"
	printf '%s\n' "$competing" > "$PUBLISH_RACE_COMMIT_FILE"
fi
exec "$REAL_GIT" "${original_args[@]}"
GIT_RACE
chmod +x "$test_dir/bin/git"
printf '# concurrent update candidate\n' > "$STAGING/package/Makefile"
if PATH="$test_dir/bin:$PATH" run_publish; then
	printf 'Publication overwrote a competing remote commit.\n' >&2
	exit 1
fi
[[ -s "$PUBLISH_RACE_COMMIT_FILE" ]]
[[ $(git --git-dir="$remote" rev-parse "refs/heads/$TARGET") == "$(cat "$PUBLISH_RACE_COMMIT_FILE")" ]]
printf 'PASS ordinary push rejects a concurrent remote update without overwriting it\n'
