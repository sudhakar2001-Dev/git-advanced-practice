# 🔀 Git Rebase -i (Interactive Rebase / Squashing)

## What It Does

Rewrites commit history by letting you **edit, reorder, squash, or drop** commits interactively. Most commonly used to **squash** multiple small commits into one clean commit before a Pull Request.

---

## When to Use It

- You made 10 messy commits ("wip", "fix typo", "oops") and want to clean them into 1–2 professional commits before your PR.
- You want to reorder commits to tell a cleaner story.
- You want to edit a commit message from 5 commits ago.
- You want to remove a commit entirely from history.

---

## Essential Commands

### Start interactive rebase for last N commits

```bash
git rebase -i HEAD~N
```

### Rebase keywords (used in the editor)

| Keyword   | Short | What It Does                                      |
|-----------|-------|---------------------------------------------------|
| `pick`    | `p`   | Keep the commit as-is                             |
| `reword`  | `r`   | Keep commit but edit its message                  |
| `edit`    | `e`   | Pause at this commit to amend it                  |
| `squash`  | `s`   | Merge into the previous commit (combine messages) |
| `fixup`   | `f`   | Merge into previous commit (discard this message) |
| `drop`    | `d`   | Delete this commit entirely                       |

### Abort a rebase

```bash
git rebase --abort
```

### Continue after resolving conflicts

```bash
git rebase --continue
```

---

## Full Workflow Example: Squashing Commits

```bash
# You have 3 commits that should be 1:
git log --oneline
# h7i8j9k Change button color
# e4f5g6h Fix button alignment
# a1b2c3d Add login button
# ... older commits ...

# 1. Start interactive rebase for the last 3 commits:
git rebase -i HEAD~3

# 2. Your editor opens with:
# ┌──────────────────────────────────────────┐
# │ pick a1b2c3d Add login button            │
# │ pick e4f5g6h Fix button alignment        │
# │ pick h7i8j9k Change button color         │
# └──────────────────────────────────────────┘

# 3. Change "pick" to "squash" for commits you want to combine:
# ┌──────────────────────────────────────────┐
# │ pick a1b2c3d Add login button            │
# │ squash e4f5g6h Fix button alignment      │
# │ squash h7i8j9k Change button color       │
# └──────────────────────────────────────────┘

# 4. Save and close the editor.

# 5. A second editor opens to write the final combined message:
# ┌──────────────────────────────────────────┐
# │ Implement styled login button            │
# │                                          │
# │ - Added login button component           │
# │ - Fixed alignment issues                 │
# │ - Applied brand colors                   │
# └──────────────────────────────────────────┘

# 6. Save and close. Done! ✅

# 7. Force push to update your remote branch:
git push --force
```

---

## Workflow Example: Reordering Commits

```bash
git rebase -i HEAD~3

# Original order:
# pick a1b2c3d Add tests
# pick e4f5g6h Add feature
# pick h7i8j9k Fix bug in feature

# Reordered (move feature before tests):
# pick e4f5g6h Add feature
# pick h7i8j9k Fix bug in feature
# pick a1b2c3d Add tests
```

---

## Handling Conflicts During Rebase

```bash
# If a conflict occurs during rebase:
# 1. Resolve the conflict in the file(s)
# 2. Stage the resolved files:
git add resolved_file.py

# 3. Continue the rebase:
git rebase --continue

# If things go very wrong, abort and start over:
git rebase --abort
```

---

## ⚠️ Important Notes

- **NEVER rebase commits that have been pushed to a shared branch** (like `main` or `develop`).
- Rebasing on your **own feature branch** is perfectly safe and expected.
- After rebasing, you **must force push**: `git push --force` (or safer: `git push --force-with-lease`).
- `--force-with-lease` is safer because it **checks** that no one else has pushed to the branch since your last pull.
- Interactive rebase is the **#1 tool** for maintaining a clean PR history.
