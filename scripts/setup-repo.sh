#!/bin/bash
# ============================================
# Git Advanced Practice - Setup Script
# ============================================
# This script initializes the repository and creates
# all the branches needed for the exercises.
# ============================================

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

echo "🚀 Setting up Git Advanced Practice Repository..."
echo "================================================="

# ---- Initialize repo if needed ----
if [ ! -d ".git" ]; then
    git init
    echo "✅ Initialized new git repository"
else
    echo "ℹ️  Git repo already exists, continuing setup..."
fi

# ---- Configure git for practice (local only) ----
git config user.email "student@practice.dev" 2>/dev/null || true
git config user.name "Git Student" 2>/dev/null || true

# ---- Initial commit on main ----
git add .
git commit -m "Initial commit: Add project structure with guides and exercises" 2>/dev/null || echo "ℹ️  Nothing new to commit on main"

# Ensure we're on main
git branch -M main 2>/dev/null || true

echo ""
echo "📦 Setting up Exercise 1: Git Stash..."
# ---- Branch for Exercise 1: Stash ----
git branch -D feature-stash 2>/dev/null || true
git checkout -b feature-stash
git checkout main

echo ""
echo "✏️  Setting up Exercise 2: Git Commit --amend..."
# ---- Branch for Exercise 2: Amend ----
git branch -D feature-amend 2>/dev/null || true
git checkout -b feature-amend
git checkout main

echo ""
echo "🍒 Setting up Exercise 3: Git Cherry-Pick..."
# ---- Branch for Exercise 3: Cherry-Pick ----

# Create feature-cherry-A (your branch)
git branch -D feature-cherry-A 2>/dev/null || true
git checkout -b feature-cherry-A
# Add a string utility
cat >> exercises/exercise-3-cherry-pick/utils.py << 'PYEOF'

def capitalize_words(text):
    """Capitalize the first letter of each word."""
    return ' '.join(word.capitalize() for word in text.split())
PYEOF
git add exercises/exercise-3-cherry-pick/utils.py
git commit -m "Add capitalize_words utility"
git checkout main

# Create feature-cherry-B (colleague's branch with the bug fix)
git branch -D feature-cherry-B 2>/dev/null || true
git checkout -b feature-cherry-B

# First commit: add a data utility (not what you need)
cat >> exercises/exercise-3-cherry-pick/utils.py << 'PYEOF'

def flatten_list(nested):
    """Flatten a nested list."""
    result = []
    for item in nested:
        if isinstance(item, list):
            result.extend(flatten_list(item))
        else:
            result.append(item)
    return result
PYEOF
git add exercises/exercise-3-cherry-pick/utils.py
git commit -m "Add flatten_list utility"

# Second commit: THE BUG FIX (this is what you'll cherry-pick!)
sed -i 's/def safe_divide(a, b):/def safe_divide(a, b):/' exercises/exercise-3-cherry-pick/utils.py
sed -i '/BUG: This function/,/return a \/ b/c\    """Safely divide two numbers.\n    \n    Returns 0 if divisor is zero.\n    """\n    if b == 0:\n        return 0\n    return a / b' exercises/exercise-3-cherry-pick/utils.py
git add exercises/exercise-3-cherry-pick/utils.py
git commit -m "Fix critical bug: safe_divide now handles zero division"

# Third commit: another feature (not what you need)
cat >> exercises/exercise-3-cherry-pick/utils.py << 'PYEOF'

def chunk_list(lst, size):
    """Split a list into chunks of given size."""
    return [lst[i:i+size] for i in range(0, len(lst), size)]
PYEOF
git add exercises/exercise-3-cherry-pick/utils.py
git commit -m "Add chunk_list utility"

git checkout main

echo ""
echo "🔀 Setting up Exercise 4: Git Rebase -i..."
# ---- Branch for Exercise 4: Rebase ----
git branch -D feature-rebase 2>/dev/null || true
git checkout -b feature-rebase

# Commit 1: Add basic auth (the "real" commit)
cat > exercises/exercise-4-rebase/user_auth.py << 'PYEOF'
"""
User Authentication Module - Git Rebase Practice
==================================================
This file will have multiple commits that you'll squash into one.
"""

import hashlib


def hash_password(password):
    """Hash a password using SHA-256."""
    return hashlib.sha256(password.encode()).hexdigest()


def login(username, password, user_db):
    """Authenticate a user against the database."""
    if username not in user_db:
        return False, "User not found"

    stored_hash = user_db[username]['password_hash']
    input_hash = hash_password(password)

    if stored_hash != input_hash:
        return False, "Incorrect password"

    return True, "Login successful"
PYEOF
git add exercises/exercise-4-rebase/user_auth.py
git commit -m "Add user authentication feature"

# Commit 2: Fix a typo (messy commit)
sed -i 's/Authenticate a user/Authenticate a user securely/' exercises/exercise-4-rebase/user_auth.py
git add exercises/exercise-4-rebase/user_auth.py
git commit -m "fix typo in login docstring"

# Commit 3: WIP (messy commit)
cat >> exercises/exercise-4-rebase/user_auth.py << 'PYEOF'


def validate_email(email):
    """Validate an email address format."""
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))
PYEOF
git add exercises/exercise-4-rebase/user_auth.py
git commit -m "wip"

# Commit 4: Fix import (messy commit)
sed -i '1a import re' exercises/exercise-4-rebase/user_auth.py
sed -i '/import re/!b;:a;n;/import re/d;ba' exercises/exercise-4-rebase/user_auth.py
git add exercises/exercise-4-rebase/user_auth.py
git commit -m "oops, fix import placement"

git checkout main

echo ""
echo "================================================="
echo "✅ Setup complete! Here's what was created:"
echo ""
echo "  Branches:"
echo "    • main              (base branch)"
echo "    • feature-stash     (Exercise 1: Git Stash)"
echo "    • feature-amend     (Exercise 2: Git Commit --amend)"
echo "    • feature-cherry-A  (Exercise 3: Your branch)"
echo "    • feature-cherry-B  (Exercise 3: Colleague's branch)"
echo "    • feature-rebase    (Exercise 4: Interactive Rebase)"
echo ""
echo "  Start with: cat exercises/exercise-1-stash/instructions.md"
echo "================================================="
