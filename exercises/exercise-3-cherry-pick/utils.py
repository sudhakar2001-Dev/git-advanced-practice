"""
Utility Functions - Git Cherry-Pick Practice
==============================================
This file exists on multiple branches with different changes.
You'll practice cherry-picking specific commits between branches.
"""


def to_uppercase(text):
    """Convert text to uppercase."""
    return text.upper()


def to_lowercase(text):
    """Convert text to lowercase."""
    return text.lower()


def reverse_string(text):
    """Reverse a string."""
    return text[::-1]


def count_words(text):
    """Count the number of words in a text."""
    return len(text.split())


def safe_divide(a, b):
    """Safely divide two numbers.
    
    BUG: This function doesn't handle zero division!
    Your colleague will fix this on feature-cherry-B.
    You'll cherry-pick that fix.
    """
    return a / b


# === YOUR PRACTICE AREA ===
# After cherry-picking, you should see the bug fix applied here.
