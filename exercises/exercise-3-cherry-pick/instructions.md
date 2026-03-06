# Exercise 3: Git Cherry-Pick Practice 🍒

## Setup
Make sure you've run `bash scripts/setup-repo.sh` first.

---

## Scenario

Two developers are working on separate feature branches:
- **feature-cherry-A** (your branch) — building string utilities
- **feature-cherry-B** (colleague's branch) — building data utilities

Your colleague fixed a critical `safe_divide` bug on their branch. You need that fix on YOUR branch right now, without merging all their other changes.

---

## Steps

### Part 1: Explore the branches

```bash
# 1. Look at the commits on feature-cherry-B (your colleague's branch):
git log feature-cherry-B --oneline

# 2. Note the commit hash for the bug fix commit
#    (It will say something about "Fix safe_divide" or "Fix critical bug")

# 3. Look at your own branch:
git checkout feature-cherry-A
git log --oneline
```

### Part 2: Cherry-pick the bug fix

```bash
# 4. Cherry-pick the bug fix commit from feature-cherry-B:
#    Replace <HASH> with the actual commit hash you found in step 2
git cherry-pick <HASH>

# 5. Verify the cherry-picked commit is now in YOUR branch:
git log --oneline

# 6. Check that the fix is in your file:
cat exercises/exercise-3-cherry-pick/utils.py
```

---

## ✅ Success Criteria

- [  ] Identified the correct commit hash from `feature-cherry-B`
- [  ] Successfully cherry-picked it onto `feature-cherry-A`
- [  ] Your branch now has the bug fix commit
- [  ] The original commit on `feature-cherry-B` is untouched

---

## 🎯 Bonus Challenge

Try cherry-picking **without auto-committing**:

```bash
# Cherry-pick but only stage the changes (don't commit yet):
git cherry-pick --no-commit <HASH>

# Review what was changed:
git diff --staged

# Now commit it with your own message:
git commit -m "Backport: safe_divide fix from feature-cherry-B"
```
