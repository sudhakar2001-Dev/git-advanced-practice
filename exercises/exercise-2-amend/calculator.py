"""
Calculator Module - Git Commit --amend Practice
=================================================
Use this file to practice amending commits.
You'll add functions and then fix your commit history.
"""


def add(a, b):
    """Add two numbers."""
    return a + b


def subtract(a, b):
    """Subtract b from a."""
    return a - b


def multiply(a, b):
    """Multiply two numbers."""
    return a * b


def divide(a, b):
    """Divide a by b safely."""
    if b == 0:
        raise ValueError("Cannot divide by zero!")
    return a / b


def modulo(a, b):
    """Return the remainder of a divided by b."""
    if b == 0:
        raise ValueError("Cannot modulo by zero!")
    return a % b


# === YOUR PRACTICE AREA ===
# Add your power() function below this line during the exercise.
