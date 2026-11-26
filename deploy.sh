#!/bin/zsh
# Copies the app into the vcent.in Jekyll repo as /github-wrapped/.
# Review with `git -C ../Vcent diff`, then commit + push only github-wrapped/.
set -e
here=${0:a:h}
dest="$here/../Vcent/github-wrapped"
mkdir -p "$dest"
# vcent.in only: add the site's cookieless PostHog snippet (the public repo stays analytics-free).
{ printf -- '---\nlayout: null\ntitle: GitHub Wrapped 2026\n---\n'; sed 's#</body>#{% include analytics.html %}\n</body>#' "$here/index.html"; } > "$dest/index.html"
grep -q 'include analytics.html' "$dest/index.html" || { echo "analytics include missing" >&2; exit 1; }
echo "Copied to $dest/index.html"
