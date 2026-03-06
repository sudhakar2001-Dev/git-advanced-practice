# ✏️ Git Commit --amend

## What It Does

Allows you to **modify the very last commit** you made. You can use it to:
- Fix a typo in the commit message
- Add files you forgot to include
- Remove files that were accidentally committed

It **replaces** the last commit with a new one (new commit hash).

---

## When to Use It

- You just committed but made a typo in the message.
- You forgot to `git add` a file before committing.
- You want to add a small fix to the last commit instead of making a new "oops" commit.

---

## Essential Commands

### Fix a commit message

```bash
git commit --amend -m "Fix critical rendering bug"
```

### Add a forgotten file (keep existing message)

```bash
git add forgotten_file.txt
git commit --amend --no-edit
```

### Open editor to modify message

```bash
git commit --amend
# Opens your configured editor (vim, nano, etc.)
```

### Remove a file from the last commit

```bash
git rm --cached accidental_file.log
git commit --amend --no-edit
```

---

## Full Workflow Example

```bash
# ---- Scenario A: Fix a typo in the commit message ----

git commit -m "Fix bgu in login page"
# Oops! Typo! Let's fix it:
git commit --amend -m "Fix bug in login page"


# ---- Scenario B: Forgot to include a file ----

git add main.py
git commit -m "Add login feature"
# Oh no, forgot to add the helper file!
git add helpers.py
git commit --amend --no-edit
# Now the last commit includes both main.py AND helpers.py ✅
```

---

## ⚠️ Important Notes

- **NEVER amend a commit that has already been pushed** to a shared branch (like `main`). This rewrites history and will cause problems for your teammates.
- If you already pushed, you'll need to `git push --force` after amending — which is **dangerous** on shared branches.
- Amending on your **own feature branch** before a PR is perfectly safe.
- `--amend` creates a **new commit hash**. The old commit is effectively replaced.
