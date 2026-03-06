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

## How It Works Internally

```
Before amend:
  A --- B --- C (HEAD, master)    ← C is the commit you want to fix

After amend:
  A --- B --- C' (HEAD, master)   ← C' is the NEW commit (new hash!)
            \
             C (orphaned)         ← Old commit is abandoned (eventually garbage collected)
```

- `--amend` does NOT edit the old commit. It **creates a brand new commit** (`C'`) with a different hash.
- The old commit (`C`) still exists temporarily but is no longer referenced by any branch.
- Git's garbage collector will eventually clean up orphaned commits.

---

## Full Workflow Examples

### Scenario A: Fix a typo in the commit message

```bash
git commit -m "Fix bgu in login page"
# Oops! Typo! Let's fix it:
git commit --amend -m "Fix bug in login page"
# ✅ The last commit now has the corrected message
```

### Scenario B: Forgot to include a file

```bash
git add main.py
git commit -m "Add login feature"
# Oh no, forgot to add the helper file!
git add helpers.py
git commit --amend --no-edit
# ✅ Now the last commit includes both main.py AND helpers.py
```

### Scenario B2: Remove a file from the last commit

```bash
git add main.py helpers.py cache.py
git commit -m "Add login feature"
# Oh no, I accidentally included cache.py! I need to remove it.

# Step 1: Remove the file from the commit (but keep it on disk)
git rm --cached cache.py
# Step 2: Amend the commit without changing the message
git commit --amend --no-edit
# ✅ Now the last commit only includes main.py and helpers.py
# ✅ cache.py is still on your disk, just not in the commit

# 💡 If you also want to DELETE the file from disk:
git rm cache.py                  # removes from commit AND disk
git commit --amend --no-edit
```

> **Key difference:**
> - `git rm --cached file` → Removes from commit only, **file stays on disk** ✅
> - `git rm file` → Removes from commit **AND deletes from disk** ⚠️
>
> **⚠️ Important:** This only removes the file from **this particular commit**.
> If the file already exists in **previous commits** in your repo history, it will still be there in those older commits.
> To remove a file from the **entire repo history**, you'd need tools like `git filter-branch` or [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) — but that's an advanced and risky operation.

### Scenario C: Add more changes to the last commit

```bash
git add app.py
git commit -m "feat: Add greet and power utility functions"
git push origin master
# ✅ Pushed to remote successfully

# Wait, I also want to add the modulo function to this same commit!
# Edit app.py to add modulo function...
git add app.py
git commit --amend -m "feat: Add greet, power, and modulo utility functions"
# ✅ The last commit now includes all three functions with updated message

# Now a normal push will FAIL ❌ (because history was rewritten)
git push origin master
# ! [rejected] master -> master (non-fast-forward)

# Solution: Force push ✅
git push --force-with-lease origin master
# ✅ Remote is now updated with the amended commit
```

---

## 🚨 Pushing After Amend (Force Push)

### The Problem

When you amend a commit that was **already pushed**, your local history diverges from the remote:

```
Remote:   A --- B --- C           ← Remote still has the OLD commit C
Local:    A --- B --- C'          ← Local has the NEW amended commit C'
```

A normal `git push` will be **rejected**:

```
! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://github.com/...'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart.
```

### The Solution: Force Push

```bash
# Option 1: Force push (overwrites remote history)
git push --force

# Option 2: Safer force push (recommended ✅)
git push --force-with-lease
```

### `--force` vs `--force-with-lease`

| Feature | `--force` | `--force-with-lease` |
|---|---|---|
| Overwrites remote | ✅ Yes | ✅ Yes |
| Checks for others' pushes | ❌ No | ✅ Yes |
| Safe for team branches | ❌ No | ⚠️ Safer, but still risky |
| Best for | Personal/solo branches | Any force push situation |

- **`--force`**: Blindly overwrites the remote. If a teammate pushed new commits, they will be **lost**.
- **`--force-with-lease`**: Checks if the remote has changed since your last fetch. If someone else pushed, it **refuses** to overwrite — protecting their work.

### When Force Push is Safe ✅

- On your **own feature branch** that nobody else is using
- On a **personal/practice repository** (like this one!)
- **Before** a pull request has been reviewed/merged

### When Force Push is Dangerous ❌

- On **shared branches** like `main`, `develop`, or `release`
- When **teammates have already pulled** the old commit
- On **production branches** — can break CI/CD pipelines

---

## Complete Real-World Workflow

```bash
# Step 1: Make a commit
git add app.py
git commit -m "feat: Add greet and power functions"

# Step 2: Push to remote
git push origin master

# Step 3: Realize you forgot something — add modulo function
# ... edit app.py ...
git add app.py
git commit --amend -m "feat: Add greet, power, and modulo utility functions"

# Step 4: Try to push (this will FAIL ❌)
git push origin master
# ! [rejected] master -> master (non-fast-forward)

# Step 5: Force push (since it's your own branch) ✅
git push --force-with-lease origin master
# ✅ Remote now has the amended commit
```

---

## 🔄 Undo an Amend (Recovering the Old Commit)

If you amend by mistake, you can recover using `git reflog`:

```bash
# Step 1: Find the old commit hash
git reflog
# You'll see something like:
# 1e8f56e (HEAD -> master) HEAD@{0}: commit (amend): feat: Add greet, power, and modulo
# a3b2c1d HEAD@{1}: commit: feat: Add greet and power functions   ← This is the OLD one

# Step 2: Reset back to the old commit
git reset --soft HEAD@{1}
# ✅ Your working directory is unchanged, but the commit is reverted to the old one
```

### Reset Options After Reflog

| Command | Effect |
|---|---|
| `git reset --soft HEAD@{1}` | Undo amend, keep changes staged |
| `git reset --mixed HEAD@{1}` | Undo amend, keep changes unstaged |
| `git reset --hard HEAD@{1}` | Undo amend, **discard all changes** (⚠️ dangerous) |

---

## ⚠️ Important Notes

- **NEVER amend a commit that has already been pushed** to a shared branch (like `main`). This rewrites history and will cause problems for your teammates.
- If you already pushed, you'll need to `git push --force` or `git push --force-with-lease` after amending.
- Amending on your **own feature branch** before a PR is perfectly safe.
- `--amend` creates a **new commit hash**. The old commit is effectively replaced.
- You can **only amend the very last commit** — to modify older commits, use `git rebase -i`.
- Use `git reflog` to recover if you amend by mistake.

---

## 📋 Quick Reference Cheatsheet

| What You Want to Do | Command |
|---|---|
| Fix commit message | `git commit --amend -m "new message"` |
| Add forgotten file (keep message) | `git add file && git commit --amend --no-edit` |
| Add more changes to last commit | `git add file && git commit --amend --no-edit` |
| Edit message in editor | `git commit --amend` |
| Remove file from commit (keep on disk) | `git rm --cached file && git commit --amend --no-edit` |
| Remove file from commit (delete from disk) | `git rm file && git commit --amend --no-edit` |
| Push after amend (safe ✅) | `git push --force-with-lease origin branch` |
| Push after amend (force ⚠️) | `git push --force origin branch` |
| Undo an amend (keep changes staged) | `git reset --soft HEAD@{1}` |
| Undo an amend (keep changes unstaged) | `git reset --mixed HEAD@{1}` |
| Undo an amend (discard all changes) | `git reset --hard HEAD@{1}` |
| View old commits (to find amend history) | `git reflog` |
