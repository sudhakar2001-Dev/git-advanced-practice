#!/bin/bash
# ============================================
# Git Advanced Practice - Reset Script
# ============================================
# Run this to completely reset the repo and start
# all exercises from scratch.
# ============================================

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "⚠️  This will reset ALL your practice progress!"
read -p "Are you sure? (y/N): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "❌ Aborted."
    exit 0
fi

echo ""
echo "🔄 Resetting repository..."

# Abort any in-progress operations
git rebase --abort 2>/dev/null || true
git cherry-pick --abort 2>/dev/null || true
git merge --abort 2>/dev/null || true

# Go back to main
git checkout main 2>/dev/null || true

# Delete all practice branches
git branch -D feature-stash 2>/dev/null || true
git branch -D feature-amend 2>/dev/null || true
git branch -D feature-cherry-A 2>/dev/null || true
git branch -D feature-cherry-B 2>/dev/null || true
git branch -D feature-rebase 2>/dev/null || true

# Clear stash
git stash clear 2>/dev/null || true

# Hard reset to initial state
git checkout -- . 2>/dev/null || true
git clean -fd 2>/dev/null || true

echo ""
echo "✅ Reset complete! Run the setup script again:"
echo "   bash scripts/setup-repo.sh"
