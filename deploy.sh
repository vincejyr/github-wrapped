#!/bin/zsh
# Copies the app into the vcent.in Jekyll repo as /github-wrapped/.
# Review with `git -C ../Vcent diff`, then commit + push only github-wrapped/.
set -e
here=${0:a:h}
dest="$here/../Vcent/github-wrapped"
mkdir -p "$dest"
{ printf -- '---\nlayout: null\ntitle: GitHub Wrapped 2026\n---\n'; cat "$here/index.html"; } > "$dest/index.html"
echo "Copied to $dest/index.html"
