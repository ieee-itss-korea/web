#!/usr/bin/env bash
# =============================================================================
# verify-build.sh — Post-build verification for the Hugo site
#
# Validates the build output before deployment. Exits non-zero if any
# required check fails, which blocks the GitHub Pages deploy.
#
# Usage:
#   bash scripts/verify-build.sh [public_dir]
#
# The only argument is the build output directory (default: ./public).
# =============================================================================
set -euo pipefail

PUBLIC_DIR="${1:-./public}"
ERRORS=0

# ---- Section list (edit here when adding new pages) -------------------------
SECTIONS=(about leadership events news membership resources contact)

# Events that must be published (edit here when adding/removing events)
# These have future dates and require buildFuture = true in hugo.toml
EVENTS=(2026-06-iv-2026 2026-09-itsc-2026 2027-06-iv-2027)

# ---- Helper functions -------------------------------------------------------

# Required file must exist — failure blocks deploy
check_file() {
  local path="$1" label="$2"
  if [ -f "${PUBLIC_DIR}/${path}" ]; then
    echo "  ✅ ${label}"
  else
    echo "  ❌ ${label}  (missing: ${path})"
    ERRORS=$((ERRORS + 1))
  fi
}

# Required file must exist AND contain a pattern
check_file_contains() {
  local path="$1" pattern="$2" label="$3"
  if [ -f "${PUBLIC_DIR}/${path}" ]; then
    if grep -q "${pattern}" "${PUBLIC_DIR}/${path}"; then
      echo "  ✅ ${label}"
    else
      echo "  ⚠️  ${label}  (file exists but pattern not found)"
    fi
  else
    echo "  ❌ ${label}  (missing: ${path})"
    ERRORS=$((ERRORS + 1))
  fi
}

# Required file must NOT contain a pattern — failure blocks deploy
check_file_not_contains() {
  local path="$1" pattern="$2" label="$3"
  if [ -f "${PUBLIC_DIR}/${path}" ]; then
    if grep -q "${pattern}" "${PUBLIC_DIR}/${path}"; then
      echo "  ❌ ${label}"
      ERRORS=$((ERRORS + 1))
    else
      echo "  ✅ ${label}"
    fi
  else
    echo "  ⚠️  ${label}  (file missing, skipped)"
  fi
}

# Optional file — warn if missing but don't block deploy
check_file_warn() {
  local path="$1" label="$2"
  if [ -f "${PUBLIC_DIR}/${path}" ]; then
    echo "  ✅ ${label}"
  else
    echo "  ⚠️  ${label}  (missing: ${path})"
  fi
}

# ---- Verification functions -------------------------------------------------

verify_redirect() {
  echo "Root redirect"
  check_file_contains "index.html" 'url=./ko/' "Root index.html → ./ko/"
}

verify_korean_pages() {
  echo "Korean pages"
  check_file_contains "ko/index.html" '한국어\|홈\|IEEE ITSS' "Korean homepage"
  for section in "${SECTIONS[@]}"; do
    check_file "ko/${section}/index.html" "/ko/${section}/"
  done
}

verify_english_pages() {
  echo "English pages (/en/)"
  check_file "en/index.html" "/en/ homepage"
  for section in "${SECTIONS[@]}"; do
    check_file "en/${section}/index.html" "/en/${section}/"
  done
}

verify_language_switcher() {
  echo "Language switcher"
  # Korean homepage must link to /en/, not to root
  check_file_contains  "ko/index.html" '/en/' "KO homepage links to /en/"
  check_file_not_contains "ko/index.html" 'class="lang-link"[^>]*href="/web/"' \
    "KO homepage does NOT link to root (would cause redirect loop)"
  # English homepage must link to /ko/
  check_file_contains  "en/index.html" '/ko/' "EN homepage links to /ko/"
}

verify_future_content() {
  echo "Future-dated content (buildFuture)"
  for event in "${EVENTS[@]}"; do
    check_file "ko/events/${event}/index.html" "/ko/events/${event}/"
    check_file "en/events/${event}/index.html" "/en/events/${event}/"
  done
  # Homepage must show upcoming events (not the "no events" empty message)
  check_file_not_contains "ko/index.html" 'class="empty-message"' \
    "KO homepage shows events (not empty message)"
}

verify_deploy_sha() {
  echo "Deploy SHA"
  if [ -n "${HUGO_DEPLOY_SHA:-}" ]; then
    local short_sha="${HUGO_DEPLOY_SHA:0:7}"
    check_file_contains "ko/index.html" "${short_sha}" "KO homepage contains deploy SHA (${short_sha})"
  else
    echo "  ⚠️  HUGO_DEPLOY_SHA not set (local build?) — skipping"
  fi
}

verify_static_assets() {
  echo "Static assets"
  check_file "css/style.css"                  "CSS stylesheet"
  check_file "images/ieee-itss-korea-logo.png" "Chapter logo"
}

print_summary() {
  echo ""
  local ko_pages en_pages
  ko_pages=$(find "${PUBLIC_DIR}/ko" -name 'index.html' 2>/dev/null | wc -l | tr -d ' ')
  en_pages=$(find "${PUBLIC_DIR}/en" -name 'index.html' 2>/dev/null | wc -l | tr -d ' ')
  echo "📊 Pages: KO=${ko_pages}, EN=${en_pages}"
  echo "📦 Total size: $(du -sh "${PUBLIC_DIR}" | cut -f1)"
}

# ---- Main -------------------------------------------------------------------

echo "=== Verifying build output (${PUBLIC_DIR}) ==="
echo ""

verify_redirect
echo ""
verify_korean_pages
echo ""
verify_english_pages
echo ""
verify_language_switcher
echo ""
verify_future_content
echo ""
verify_deploy_sha
echo ""
verify_static_assets

print_summary

echo ""
if [ "${ERRORS}" -gt 0 ]; then
  echo "🚫 Build verification failed with ${ERRORS} error(s)"
  exit 1
else
  echo "✅ Build verification passed"
fi
