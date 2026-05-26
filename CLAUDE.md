# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The **IEEE ITSS Korea Chapter** website — a bilingual (Korean/English) [Hugo](https://gohugo.io) site deployed to GitHub Pages at <https://ieee-itss-korea.github.io/web/>. Config is `hugo.toml`; content is Markdown under `content/`. Layout, theme, and UI strings are in `layouts/`, `static/`, and `i18n/`. There is no external theme — templates are hand-written in `layouts/`.

## Build / preview / deploy

- **Local preview:** `hugo server -D` → <http://localhost:1313/web/>. `-D` includes drafts so you can see unpublished pages.
- **Hugo version:** **0.155.2 extended** (pinned in `.github/workflows/hugo.yml`). The extended build is required.
- **Deploy is automatic.** Pushing **to `main`** triggers `.github/workflows/hugo.yml`, which builds with `hugo --gc --minify`, runs two post-build scripts, and publishes to GitHub Pages. The build job runs on *any* push; only the `deploy` job is gated to `main`. So a PR branch gets a build/verify check but does **not** go live until merged.
- Production build sets `TZ=Asia/Seoul`; date display assumes KST.

## Content taxonomy — news vs events (read this first)

The single most important rule when adding content:

- **`content/events/`** — conferences, Distinguished Lectures, webinars, chapter meetings, networking dinners: anything with a date/place you attend. Front matter **must** include `draft: false`, `event_date:`, and `location:` (plus `speaker:` for talks). Filenames are `YYYY-MM-shortname.{en,ko}.md` (e.g. `2026-06-dl-levin.en.md`). `date:` is the **event start date**.
- **`content/news/`** — time-bound announcements: calls for nominations, program introductions, awards news. Front matter is just `title:`, `date:`, `description:` — **no** `event_date`/`location`, and news files conventionally **omit `draft:` entirely** (they publish on merge). `date:` is the announcement date.

When in doubt: *does it have a venue and a time you'd put on a calendar?* → event. *Is it a chapter announcement?* → news. Putting a conference in `news/` is the common mistake.

Other sections (`about/`, `leadership/`, `membership/`, `resources/`, `contact/`) are single landing pages built from `_index.{en,ko}.md`.

## Bilingual `.en` / `.ko` convention

- Every page is a paired `name.ko.md` + `name.en.md`. Always create/edit **both**; an orphaned single-language file is a defect.
- **Korean is default**, served at `/ko/`; English at `/en/`. Root `/` redirects to `/ko/`. Set in `hugo.toml` (`defaultContentLanguage = "ko"`, `defaultContentLanguageInSubdir = true`).
- Hugo 0.155.2 emits the non-default (English) pages at the root instead of `/en/`; `scripts/fix-language-paths.sh` mirrors them into `/en/` and writes the root redirect during the CI build. Don't hand-fix paths — that's the script's job.
- UI strings (menu labels, button text) live in `i18n/ko.toml` and `i18n/en.toml`, not in content.

## Draft → publish flow

- `draft: true` hides a page from the production build (`--gc --minify`, no `-D`); flip to `draft: false` to publish.
- New event pages scaffold with `draft: true` (see `archetypes/events.md`); flip to `false` when ready to ship.
- News posts generally carry no `draft:` field and go live on merge — only add `draft: true` if you explicitly want to stage one.
- Create new content from archetypes: `hugo new events/2026-06-foo.ko.md` (and the `.en.md`), or copy an existing pair.

## Contribution workflow (as practiced)

Changes land via **PR to `main` with `kangwonlee` requested as reviewer** — never push to `main` directly. Branch names follow the change, e.g. `event/2026-06-dl-levin`, `add-france-talk-saidi`, `draft-dissertation-award-news`. See the live pattern in any recent PR (e.g. #16). Commit messages are sentence-style and descriptive of the publish action, e.g. *"Publish ICVES 2026 as event: move news→events, draft:false, confirm Sep 1 registration deadline"*.

## Pitfalls

- **`scripts/verify-build.sh` has hardcoded `SECTIONS` and `EVENTS` arrays.** It asserts each listed event page exists in both `/ko/` and `/en/` and **fails the deploy** if one is missing. The `EVENTS` list is *not* auto-maintained and is already stale (several live events aren't in it). It won't block you for omissions, but if you *rename or remove* a listed event, update the array or CI goes red. Keep `SECTIONS` in sync with the menu in `hugo.toml` and the `SECTIONS` array in `fix-language-paths.sh`.
- **Paired-file discipline:** forgetting the `.en.md` (or `.ko.md`) half leaves a half-translated page; the language switcher then dead-ends.
- **Event front matter is mandatory:** an event without `draft: false` stays hidden in production; without `event_date`/`location` it renders incompletely in the events list.
- `buildFuture = true` is set, so future-dated events build and show — there is no "publishes on its date" gating. A future event is visible the moment it merges.
- Stray untracked files sometimes sit in `content/news/` on working branches (e.g. half-finished post pairs). Don't `git add -A` — stage files by name so you don't sweep them into an unrelated PR.
