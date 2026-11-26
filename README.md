# GitHub Wrapped 2026

**Live: https://www.vcent.in/github-wrapped/** · try it with `?u=<username>`

A Spotify-Wrapped-style recap of anyone's year on GitHub. Type a username and you get:

1. **A story**: about 11 full-screen cards that auto-advance (tap left or right, hold to pause, or use the arrow keys)
2. **Shareable cards**: PNGs drawn on a canvas, 4:5 for posts and 9:16 for stories. Phones open the share sheet.
3. **Hosting**: www.vcent.in/github-wrapped/ (a static page in the Vcent Jekyll repo)

## How it works
One static `index.html` with no build step and no backend. It runs entirely in the browser.

| Data | Source |
|---|---|
| Profile, repos, stars | GitHub REST API (core limit: 60 requests/hour per visitor IP) |
| Commits, hour of day, top repos | `search/commits` (sample of the most recent 200 commits) |
| PRs, merged PRs, reviews, issues | `search/issues` counts (search limit: 10 requests/min) |
| Languages | `/repos/:r/languages` for the top 5 repos, weighted by commits |
| Contribution calendar, streaks, busiest day | github-contributions-api.jogruber.de (scrapes the public profile graph) |

One wrap costs about 9 core and 6 search requests. Results are cached in localStorage for 6 hours.

URL params: `?u=<login>` starts a wrap automatically, `?y=2025` picks another year, `?debug` exposes `window.__gw.drawCard`.

## Fork it
Everything is in one `index.html` file with no build step and no API keys. To host your own copy:
1. Fork this repo.
2. In the fork, go to **Settings → Pages → Deploy from a branch → `main` / root**.
3. Your copy goes live at `https://<you>.github.io/github-wrapped/`. The share card footer picks up that URL automatically.

Ideas to build on: a token field for private stats, more personality types, more share-card themes.

## Develop / deploy (vcent.in)
```
python3 -m http.server 8765   # open http://localhost:8765/?u=torvalds
./deploy.sh                   # copies into ../Vcent/github-wrapped/index.html with Jekyll front matter
```
`deploy.sh` is specific to my setup: it copies the page into my site repo. Then commit and push **only** `github-wrapped/` in the Vcent repo. Pushing to main deploys in about 1 minute.

## License
MIT
