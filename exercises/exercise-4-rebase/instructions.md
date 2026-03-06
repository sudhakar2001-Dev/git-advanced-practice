# Exercise 4: Git Rebase -i (Squashing) Practice 🔀

## Setup
Make sure you've run `bash scripts/setup-repo.sh` first.

---

## Scenario

You've been working on a user authentication feature. During development, you made several messy commits like "wip", "fix typo", and "oops forgot semicolon". Before submitting a Pull Request, you want to squash them into **one clean, professional commit**.

---

## Steps

### Part 1: Review the messy history

```bash
# 1. Switch to the feature-rebase branch
git checkout feature-rebase

# 2. Look at the messy commit history:
git log --oneline
# You should see something like:
# abc1234 oops, fix import
# def5678 wip
# ghi9012 fix typo in login
# jkl3456 Add user authentication feature
# ... (older commits) ...
```

### Part 2: Squash the commits

```bash
# 3. Start interactive rebase for the last 4 commits:
git rebase -i HEAD~4

# 4. Your editor will show something like:
#    pick jkl3456 Add user authentication feature
#    pick ghi9012 fix typo in login  
#    pick def5678 wip
#    pick abc1234 oops, fix import

# 5. Change it to (keep first as "pick", change rest to "squash"):
#    pick jkl3456 Add user authentication feature
#    squash ghi9012 fix typo in login
#    squash def5678 wip
#    squash abc1234 oops, fix import

# 6. Save and close the editor.

# 7. A new editor will open for the combined commit message.
#    Replace everything with a clean message:
#    "Implement user authentication with login and validation"

# 8. Save and close.
```

### Part 3: Verify the result

```bash
# 9. Check your clean history:
git log --oneline
# You should now see just ONE commit instead of four!

# 10. Verify all the changes are still there:
cat exercises/exercise-4-rebase/user_auth.py
```

---

## ✅ Success Criteria

- [  ] Successfully started an interactive rebase
- [  ] Squashed 4 commits into 1 clean commit
- [  ] The final commit has a professional message
- [  ] All code changes are preserved in the single commit
- [  ] The commit history is clean

---

## 🎯 Bonus Challenge

Try using `fixup` instead of `squash`:

```bash
# Reset and try again:
git reflog
# Find the hash before the rebase and reset:
git reset --hard <hash-before-rebase>

# Now use fixup (discards commit messages automatically):
git rebase -i HEAD~4
# pick jkl3456 Add user authentication feature
# fixup ghi9012 fix typo in login
# fixup def5678 wip
# fixup abc1234 oops, fix import
```

**Difference:** `squash` lets you combine all messages, `fixup` silently discards the squashed commit's messages and uses only the first commit's message.
