"""
Simple Application - Git Stash Practice
========================================
Use this file to practice git stash.
You'll be adding new functions here while practicing stashing changes.
"""


def add(a, b):
    """Add two numbers together."""
    return a + b


def subtract(a, b):
    """Subtract b from a."""
    return a - b


def multiply(a, b):
    """Multiply two numbers."""
    return a * b


def divide(a, b):
    """Divide a by b."""
    if b == 0:
        raise ValueError("Cannot divide by zero!")
    return a / b


# === YOUR PRACTICE AREA ===
# Add your new functions below this line during the exercise.
# Try adding a greeting function, then stashing it!


def greet(name):
    """Return a greeting message."""
    return f"Hello, {name}! Welcome to the app."


def power(base, exponent):
    """Raise base to the given exponent."""
    return base ** exponent


def modulo(a, b):
    """Return the remainder of a divided by b."""
    if b == 0:
        raise ValueError("Cannot perform modulo by zero!")
    return a % b
