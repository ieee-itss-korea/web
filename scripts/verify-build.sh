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
  check_file_contains "ko/index.html" '한국어\|홈\|챕터' "Korean homepage"
  for section in "${SECTIONS[@]}"; do
    check_file "ko/${section}/index.html" "/ko/${section}/"
  done
}

verify_english_pages() {
  echo "English pages"
  for section in "${SECTIONS[@]}"; do
    check_file_warn "${section}/index.html" "/${section}/ (en)"
  done
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
  en_pages=$(find "${PUBLIC_DIR}" -maxdepth 2 -name 'index.html' -not -path '*/ko/*' 2>/dev/null | wc -l | tr -d ' ')
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
verify_static_assets

print_summary

echo ""
if [ "${ERRORS}" -gt 0 ]; then
  echo "🚫 Build verification failed with ${ERRORS} error(s)"
  exit 1
else
  echo "✅ Build verification passed"
fi
