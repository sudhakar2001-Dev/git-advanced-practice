"""
User Authentication Module - Git Rebase Practice
==================================================
This file will have multiple commits that you'll squash into one.
"""

import hashlib
import re


def validate_email(email):
    """Validate an email address format."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))


def hash_password(password):
    """Hash a password using SHA-256."""
    return hashlib.sha256(password.encode()).hexdigest()


def check_password_strength(password):
    """Check if a password meets minimum security requirements."""
    if len(password) < 8:
        return False, "Password must be at least 8 characters"
    if not any(c.isupper() for c in password):
        return False, "Password must contain at least one uppercase letter"
    if not any(c.isdigit() for c in password):
        return False, "Password must contain at least one digit"
    return True, "Password is strong"


def login(username, password, user_db):
    """Authenticate a user against the database."""
    if username not in user_db:
        return False, "User not found"

    stored_hash = user_db[username]['password_hash']
    input_hash = hash_password(password)

    if stored_hash != input_hash:
        return False, "Incorrect password"

    return True, "Login successful"


def register(username, email, password, user_db):
    """Register a new user."""
    if username in user_db:
        return False, "Username already taken"

    if not validate_email(email):
        return False, "Invalid email format"

    is_strong, msg = check_password_strength(password)
    if not is_strong:
        return False, msg

    user_db[username] = {
        'email': email,
        'password_hash': hash_password(password)
    }
    return True, "Registration successful"
