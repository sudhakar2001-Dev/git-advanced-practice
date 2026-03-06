# 🔄 Git Branch Rename Guide

> Fix branch name typos by renaming locally and updating the remote.

---

## 📌 When to Use

- You created a branch with a **typo** (e.g., `updae-repo` instead of `update-repo`)
- You want to **rename** an existing branch to a better name

---

## 🔧 Step-by-Step: Rename a Branch

### Step 1: Rename the Local Branch

If you're **currently on** the branch you want to rename:

```bash
git branch -m "old-name" "new-name"
```

**Example:**

```bash
git branch -m "updae-repo" "update-repo"
```

> `-m` stands for "move" (rename).

If you're on a **different branch**, the same command works — just specify both old and new names.

---

### Step 2: Delete the Old Remote Branch

If the old branch was already pushed to the remote, delete it:

```bash
git push origin --delete "old-name"
```

**Example:**

```bash
git push origin --delete "updae-repo"
```

---

### Step 3: Push the Renamed Branch to Remote

```bash
git push origin "new-name"
```

**Example:**

```bash
git push origin "update-repo"
```

---

### Step 4: Set Upstream Tracking

Link your local branch to the new remote branch:

```bash
git push origin -u "new-name"
```

**Example:**

```bash
git push origin -u "update-repo"
```

---

## 📋 Quick Reference

| Step | Command                                  | Purpose                        |
|------|------------------------------------------|--------------------------------|
| 1    | `git branch -m "old" "new"`              | Rename the local branch        |
| 2    | `git push origin --delete "old"`         | Delete old branch from remote  |
| 3    | `git push origin "new"`                  | Push renamed branch to remote  |
| 4    | `git push origin -u "new"`              | Set upstream tracking          |

---

## ⚠️ Important Tips

- **Avoid spaces in branch names** — use hyphens (`-`) or underscores (`_`) instead.
  - ✅ `update-repo`, `update_repo`
  - ❌ `update repo`
- **Coordinate with your team** — if others are working on the old branch, let them know about the rename so they can update their local references.
- If the branch has an **open Pull Request**, renaming the branch may close it. You'll need to open a new PR from the renamed branch.

---

## 🧪 Practice Exercise

1. Create a branch with a typo:
   ```bash
   git checkout -b "feture-login"
   ```

2. Rename it to the correct name:
   ```bash
   git branch -m "feture-login" "feature-login"
   ```

3. Verify the rename:
   ```bash
   git branch
   ```

4. Push and set upstream (if using a remote):
   ```bash
   git push origin -u "feature-login"
   ```

---

**Happy branching! 🌿**
