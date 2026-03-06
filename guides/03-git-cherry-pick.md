# 🍒 Git Cherry-Pick

## What It Does

Takes a **specific commit** from one branch and applies it directly to the branch you are currently on. It creates a **new commit** on your branch with the same changes.

Think of it as copy-pasting a single commit from one branch to another.

---

## When to Use It

- A colleague fixed a bug on their branch, and you need that fix on yours **right now**.
- You want to backport a specific fix to a release branch.
- You accidentally committed to the wrong branch and want to move the commit.

---

## Essential Commands

### Cherry-pick a single commit

```bash
git cherry-pick <commit-hash>
```

### Cherry-pick multiple commits

```bash
git cherry-pick <hash1> <hash2> <hash3>
```

### Cherry-pick without auto-committing (stage changes only)

```bash
git cherry-pick --no-commit <commit-hash>
```

### Abort a cherry-pick if there are conflicts

```bash
git cherry-pick --abort
```

### Continue after resolving conflicts

```bash
git cherry-pick --continue
```

---

## Full Workflow Example

```bash
# 1. Your colleague fixed a critical bug on feature-B.
#    Find the commit hash:
git log feature-B --oneline
# Output:
# a1b2c3d Fix null pointer crash in user profile
# e4f5g6h Add profile picture upload
# h7i8j9k Refactor profile page layout

# 2. You only need the bug fix (a1b2c3d), not the other changes.
#    Make sure you're on YOUR branch:
git checkout feature-A

# 3. Cherry-pick just that one commit:
git cherry-pick a1b2c3d

# 4. Done! The fix is now on your branch too. ✅
git log --oneline
# Output:
# x9y8z7w Fix null pointer crash in user profile  ← NEW commit (different hash!)
# ... your other commits ...
```

---

## Handling Conflicts

```bash
# If the cherry-pick results in a conflict:
git cherry-pick a1b2c3d
# CONFLICT (content): Merge conflict in file.py

# 1. Open the conflicted file(s) and resolve the conflicts manually
# 2. Stage the resolved files:
git add file.py

# 3. Continue the cherry-pick:
git cherry-pick --continue
```

---

## ⚠️ Important Notes

- Cherry-pick creates a **new commit with a different hash** — it's a copy, not a move.
- The original commit on the source branch is **untouched**.
- If the same commit is later merged through a normal merge, Git is usually smart enough to handle it.
- Use cherry-pick **sparingly** — overusing it can make history confusing. If you need many commits, consider merging or rebasing instead.
