# 📦 Git Stash

## What It Does

Temporarily shelves (or "stashes") changes you've made to your working directory so you can work on something else, **without having to commit half-finished work**.

Think of it as a clipboard for your uncommitted changes.

---

## When to Use It

- You're halfway through a feature but need to urgently switch branches.
- You want to pull the latest changes from remote but have local modifications.
- You want to experiment with something and might want to undo it.

---

## Essential Commands

### Save your changes to the stash

```bash
git stash
```

This stashes **both staged and unstaged** tracked file changes, then reverts your working directory to match HEAD.

### Save with a descriptive message

```bash
git stash push -m "WIP: login form validation"
```

### List all stashes

```bash
git stash list
# Output:
# stash@{0}: On branch-A: WIP: login form validation
# stash@{1}: WIP on main: abc1234 Previous commit message
```

### Restore the most recent stash (and remove it from stash list)

```bash
git stash pop
```

### Restore but keep in stash list

```bash
git stash apply
```

### Restore a specific stash

```bash
git stash pop stash@{2}
```

### Delete a specific stash

```bash
git stash drop stash@{1}
```

### Clear ALL stashes

```bash
git stash clear
```

---

## Full Workflow Example

```bash
# 1. You're working on feature-A with uncommitted changes
echo "new feature code" >> feature.py

# 2. Urgent bug fix needed! Stash your work:
git stash push -m "WIP: feature-A halfway done"

# 3. Switch to main and fix the bug:
git checkout main
git pull
# ... fix the bug, commit, push ...

# 4. Switch back and restore your work:
git checkout feature-A
git stash pop

# 5. Continue where you left off! ✅
```

---

## ⚠️ Important Notes

- `git stash` does **NOT** stash untracked files by default. Use `git stash -u` to include them.
- `git stash pop` can cause **merge conflicts** if the stashed changes conflict with new changes. Resolve them like any normal merge conflict.
- Stashes are **local only** — they are never pushed to the remote.
