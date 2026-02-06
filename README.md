# IEEE ITSS Korea Chapter Website

Official website of the IEEE ITSS Korea Chapter, built with [Hugo](https://gohugo.io) and hosted on GitHub Pages.

- **Live site:** https://ieee-itss-korea.github.io/web/
- **Founded:** December 2, 2025

## Quick Start (Local Development)

### 1. Install Hugo

**macOS (Homebrew):**
```bash
brew install hugo
```

**Windows (Chocolatey):**
```bash
choco install hugo-extended
```

**Linux (Snap):**
```bash
snap install hugo
```

Or download from [Hugo releases](https://github.com/gohugoio/hugo/releases). You need the **extended** version.

### 2. Clone and run locally

```bash
git clone https://github.com/ieee-itss-korea/web.git
cd web
hugo server -D
```

Open http://localhost:1313/web/ in your browser. Changes reload automatically.

## Project Structure

```
.
├── .github/workflows/hugo.yml  ← GitHub Actions (auto-deploy on push)
├── hugo.toml                   ← Site configuration & bilingual settings
├── content/                    ← Markdown content (ko/en pairs)
│   ├── _index.ko.md            ← Korean homepage
│   ├── _index.en.md            ← English homepage
│   ├── about/                  ← Chapter introduction
│   ├── leadership/             ← Officers
│   ├── events/                 ← Seminars, workshops, DL talks
│   ├── news/                   ← Announcements
│   ├── membership/             ← How to join
│   ├── resources/              ← Journals, conferences, links
│   └── contact/                ← Contact info & community links
├── i18n/                       ← UI string translations
│   ├── ko.toml
│   └── en.toml
├── layouts/                    ← HTML templates
│   ├── _default/               ← baseof, single, list
│   ├── partials/               ← header, footer
│   └── index.html              ← Homepage template
├── static/
│   ├── css/style.css           ← Stylesheet (IEEE-branded)
│   └── images/                 ← Logos, photos
└── archetypes/                 ← Templates for new content
```

## How the Bilingual System Works

Every content page has a **Korean** (`.ko.md`) and **English** (`.en.md`) counterpart:

```
content/about/_index.ko.md   →  /about/         (Korean)
content/about/_index.en.md   →  /en/about/      (English)
```

Korean is the default language at `/`. English translations live under `/en/`.

The language switcher in the navigation bar automatically links between paired translations.

### Adding new bilingual content

```bash
# Create a news post (both languages)
hugo new news/2026-03-my-post.ko.md
hugo new news/2026-03-my-post.en.md
```

Or just copy an existing `.ko.md` / `.en.md` pair and edit.

### Adding a new event

```bash
hugo new events/2026-06-dl-seminar.ko.md
```

Then edit the front matter:

```yaml
---
title: "Distinguished Lecturer 초청 세미나"
date: 2026-06-15
event_date: "2026년 6월 15일 (월) 14:00–16:00"
location: "서울 ○○대학교"
speaker: "Dr. Jane Doe, MIT"
draft: false
---
```

## Configuration Checklist

After cloning, update these items in `hugo.toml`:

| Setting | What to fill in |
|---------|----------------|
| `params.linkedinURL` | Your LinkedIn Group URL |
| `params.collabratecURL` | Your IEEE Collabratec Workspace URL |
| `params.kakaoOpenChatURL` | Your KakaoTalk Open Chat URL |

Also replace:
- `static/images/ieee-itss-logo.png` — ITSS chapter logo (download from [ITSS Brand page](https://ieee-itss.org/about/brand/))
- `static/images/ieee-mb-white.png` — IEEE master brand mark (white version, from [IEEE Brand Experience](https://brand-experience.ieee.org))
- `static/images/favicon.ico` — Site favicon
- Officer information in `content/leadership/`
- Contact emails in `content/contact/`

## Deployment

Deployment is **automatic**. Every push to `main` triggers the GitHub Actions workflow, which:

1. Builds the site with Hugo
2. Deploys to GitHub Pages

No manual steps needed after the initial setup (see below).

## GitHub Repository & Organization Setup

### One-time setup for the `ieee-itss-korea` organization:

#### Step 1: Enable GitHub Pages

1. Go to **github.com/ieee-itss-korea/web** → **Settings** → **Pages**
2. Under **Source**, select **GitHub Actions**
3. Save

#### Step 2: Set repository visibility

- The repository must be **Public** for free GitHub Pages hosting under an organization
- (Private repos require GitHub Pro/Team/Enterprise for Pages)

#### Step 3: Verify the first deployment

1. Push the scaffolded code to `main`
2. Go to **Actions** tab → watch the "Deploy Hugo site to Pages" workflow
3. Once green, visit https://ieee-itss-korea.github.io/web/

### Optional: Custom domain (for later)

1. In repo **Settings → Pages → Custom domain**, enter your domain
2. Add a `CNAME` record with your DNS provider pointing to `ieee-itss-korea.github.io`
3. Create a file `static/CNAME` containing your domain name
4. Update `baseURL` in `hugo.toml`

### Organization settings (recommended)

- Under **github.com/organizations/ieee-itss-korea/settings**:
  - Set a profile picture (IEEE ITSS logo)
  - Add a description and link to the live site
  - Add chapter officers as organization members with appropriate roles

## Content Editing for Non-Technical Members

Members who are not familiar with Git can edit content directly on GitHub:

1. Navigate to the file in the `content/` folder on github.com
2. Click the pencil icon (Edit)
3. Make changes to the Markdown text
4. Click "Commit changes" with a description
5. The site rebuilds automatically

## License

Content is copyright IEEE. Site structure and templates are available for reuse by other IEEE chapters.
