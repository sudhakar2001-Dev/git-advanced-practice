# 📋 Git Advanced Commands Cheatsheet

Quick reference for all commands covered in this practice repo.

---

## 📦 Stash

| Command | Description |
|---------|-------------|
| `git stash` | Stash tracked changes |
| `git stash -u` | Stash including untracked files |
| `git stash push -m "msg"` | Stash with a label |
| `git stash list` | List all stashes |
| `git stash pop` | Restore & remove from stash |
| `git stash apply` | Restore & keep in stash |
| `git stash drop stash@{N}` | Delete a specific stash |
| `git stash clear` | Delete ALL stashes |

---

## ✏️ Commit --amend

| Command | Description |
|---------|-------------|
| `git commit --amend -m "new msg"` | Change last commit message |
| `git commit --amend --no-edit` | Add staged files to last commit |
| `git commit --amend` | Open editor for last commit |

---

## 🍒 Cherry-Pick

| Command | Description |
|---------|-------------|
| `git cherry-pick <hash>` | Apply a commit to current branch |
| `git cherry-pick --no-commit <hash>` | Stage changes without committing |
| `git cherry-pick --abort` | Cancel cherry-pick |
| `git cherry-pick --continue` | Continue after conflict resolution |

---

## 🔀 Interactive Rebase

| Command | Description |
|---------|-------------|
| `git rebase -i HEAD~N` | Rebase last N commits |
| `git rebase --abort` | Cancel rebase |
| `git rebase --continue` | Continue after conflict resolution |
| `git push --force` | Force push after rebase |
| `git push --force-with-lease` | Safer force push |

### Rebase Editor Keywords

| Keyword | Short | Effect |
|---------|-------|--------|
| `pick` | `p` | Keep commit as-is |
| `reword` | `r` | Edit commit message |
| `squash` | `s` | Merge into previous (combine messages) |
| `fixup` | `f` | Merge into previous (discard message) |
| `drop` | `d` | Delete commit |
| `edit` | `e` | Pause to amend |

---

## 🆘 Undo / Rescue

| Command | Description |
|---------|-------------|
| `git reflog` | See ALL recent actions (lifesaver!) |
| `git reset --hard <hash>` | Reset to a specific point |
| `git rebase --abort` | Undo an in-progress rebase |
| `git cherry-pick --abort` | Undo an in-progress cherry-pick |

---

> 💡 **Pro Tip:** When in doubt, `git reflog` can help you find any previous state of your repo and recover from mistakes!
