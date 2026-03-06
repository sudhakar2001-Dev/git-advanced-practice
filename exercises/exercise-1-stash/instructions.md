# Exercise 1: Git Stash Practice 📦

## Setup
Make sure you've run `bash scripts/setup-repo.sh` first.

---

## Scenario

You are working on `app.py` adding a new feature (a greeting function). You're halfway through when an urgent bug is reported on the `main` branch. You need to switch branches, fix the bug, and come back to your feature work.

---

## Steps

### Part 1: Create uncommitted work

```bash
# 1. Switch to the feature-stash branch
git checkout feature-stash

# 2. Open app.py and add a new function at the bottom:
echo '
def greet(name):
    """A new greeting feature - work in progress"""
    message = f"Hello, {name}!"
    # TODO: Add more greeting styles
    return message
' >> exercises/exercise-1-stash/app.py

# 3. Check your status — you should see modified files:
git status
```

### Part 2: Stash and switch

```bash
# 4. Stash your changes with a descriptive message:
git stash push -m "WIP: greeting feature in app.py"

# 5. Verify your working directory is clean:
git status

# 6. Verify the stash was saved:
git stash list

# 7. Switch to main to handle the "urgent bug":
git checkout main
```

### Part 3: Fix the "bug" and come back

```bash
# 8. Switch back to your feature branch:
git checkout feature-stash

# 9. Restore your stashed changes:
git stash pop

# 10. Verify your greeting function is back:
cat exercises/exercise-1-stash/app.py
git status
```

---

## ✅ Success Criteria

- [  ] You successfully stashed uncommitted changes
- [  ] Switched branches with a clean working directory
- [  ] Restored your stashed changes with `git stash pop`
- [  ] Your greeting function code is back in `app.py`

---

## 🎯 Bonus Challenge

Try stashing with untracked files:

```bash
# Create a new untracked file
echo "config data" > new_config.txt

# Regular stash won't include it — try:
git stash -u -m "WIP: including untracked files"
git stash pop
```
