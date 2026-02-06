#!/usr/bin/env bash
# =============================================================================
# fix-language-paths.sh — Fix Hugo multilingual output paths
#
# Hugo (as of v0.155.2) with defaultContentLanguageInSubdir = true places
# the non-default language (English) at the root level instead of /en/.
# This script:
#   1. Copies root-level English pages into /en/ so menu links work
#   2. Overwrites root index.html with a redirect to /ko/
#
# Usage:
#   bash scripts/fix-language-paths.sh [public_dir]
# =============================================================================
set -euo pipefail

PUBLIC_DIR="${1:-./public}"

# Sections to mirror (keep in sync with verify-build.sh SECTIONS)
SECTIONS=(about leadership events news membership resources contact)

echo "=== Fixing language paths (${PUBLIC_DIR}) ==="

# ---- Step 1: Mirror English pages from root into /en/ -----------------------
echo ""
echo "Mirroring English pages → /en/"
mkdir -p "${PUBLIC_DIR}/en"

# Copy the root homepage (English) to /en/ before we overwrite it
if [ -f "${PUBLIC_DIR}/index.html" ]; then
  cp "${PUBLIC_DIR}/index.html" "${PUBLIC_DIR}/en/index.html"
  echo "  ✅ /en/index.html"
fi

# Copy each section
for section in "${SECTIONS[@]}"; do
  if [ -d "${PUBLIC_DIR}/${section}" ]; then
    cp -r "${PUBLIC_DIR}/${section}" "${PUBLIC_DIR}/en/${section}"
    echo "  ✅ /en/${section}/"
  else
    echo "  ⚠️  /${section}/ not found — skipping"
  fi
done

# Copy news sub-pages (individual articles live under /news/*)
# Already handled by cp -r above

# ---- Step 2: Overwrite root with Korean redirect ----------------------------
echo ""
echo "Writing root redirect → ./ko/"
cat > "${PUBLIC_DIR}/index.html" << 'REDIRECT'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="refresh" content="0; url=./ko/">
  <link rel="canonical" href="./ko/">
  <title>IEEE ITSS Korea Chapter</title>
</head>
<body>
  <p>Redirecting to <a href="./ko/">한국어 페이지</a>...</p>
</body>
</html>
REDIRECT
echo "  ✅ Root redirect written"

echo ""
echo "=== Language path fix complete ==="
