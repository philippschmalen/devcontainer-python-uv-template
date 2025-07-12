# GitHub Copilot Instructions

This is a production-ready Python project template for senior data scientists and Python developers.

## TLDR: Essential Rules

**Simplicity first** – keep functions small, clear, and free of bloat. Clarity > cleverness. YAGNI principle. Single responsibility. Composition over inheritance. Fail fast & loud. Immutable by default. Be explicit, not clever. Descriptive names with why & what instead of how. Typed & pythonic.

**Tooling**: Use `uv` for dependencies, Ruff for formatting, MyPy for types, pytest for tests, pre-commit hooks.

**Config**: `.env` files, structured logging via `src/config/logging_config.py`, 12-factor principles.

**Testing**: Descriptive names `test_<function>_<scenario>`, mock externals, pytest fixtures.

**Errors**: Specific exceptions, no bare except, context managers for resources.

When coding, prioritize: clarity, type safety, consistency, proper testing.
