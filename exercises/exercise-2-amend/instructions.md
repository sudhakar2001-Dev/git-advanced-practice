# Exercise 2: Git Commit --amend Practice ✏️

## Setup
Make sure you've run `bash scripts/setup-repo.sh` first.

---

## Scenario

You're building a calculator module. You'll practice fixing commit messages and adding forgotten files to the last commit.

---

## Steps

### Part 1: Fix a typo in a commit message

```bash
# 1. Switch to the feature-amend branch
git checkout feature-amend

# 2. Make a change to calculator.py (add a power function):
cat >> exercises/exercise-2-amend/calculator.py << 'EOF'

def power(base, exponent):
    """Raise base to the power of exponent."""
    return base ** exponent
EOF

# 3. Stage and commit with a TYPO in the message:
git add exercises/exercise-2-amend/calculator.py
git commit -m "Add powr function to calcualtor"

# 4. Check the log — see the typo?
git log --oneline -1

# 5. Fix it with --amend:
git commit --amend -m "Add power function to calculator"

# 6. Verify the fix:
git log --oneline -1
```

### Part 2: Add a forgotten file to the last commit

```bash
# 7. Create a test file that should have been part of the commit:
cat > exercises/exercise-2-amend/test_calculator.py << 'EOF'
"""Tests for the calculator module."""

from calculator import power

def test_power():
    assert power(2, 3) == 8
    assert power(5, 0) == 1
    assert power(10, 1) == 10
    print("All tests passed! ✅")

if __name__ == "__main__":
    test_power()
EOF

# 8. Add the forgotten file and amend the previous commit:
git add exercises/exercise-2-amend/test_calculator.py
git commit --amend --no-edit

# 9. Verify both files are now in the last commit:
git log --oneline -1
git show --stat HEAD
```

---

## ✅ Success Criteria

- [  ] Fixed the typo in the commit message using `--amend`
- [  ] Added the forgotten test file using `--amend --no-edit`
- [  ] The last commit now contains **both** `calculator.py` changes and `test_calculator.py`
- [  ] There is only **one** commit for all of this (not two or three)
