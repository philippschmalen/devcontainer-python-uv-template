# AGENTS.md

This file provides guidance for AI coding agents when working with this Python project template.

## Project Overview

This is a production-ready Python project template designed for senior data scientists and Python developers. The template provides a complete development environment with Docker containers, modern dependency management, and comprehensive quality tools to jumpstart Python projects with best practices built-in.

## Workspace Structure

This is a standard Python project with uv dependency management:

- `src/`: Source code with modular architecture
- `tests/`: Test files mirroring source structure
- `docs/`: Documentation
- `docker-compose.yml`: Development environment
- `pyproject.toml`: Project configuration
- `.env.sample`: Environment template

## Development Commands

### Core Development Tasks
- Install dependencies: `uv sync`
- Run all checks: `pre-commit run --all-files`
- Run tests: `pytest`
- Format code: `ruff format`
- Lint code: `ruff check --fix`
- Type check: `mypy src/`

### Single Test Commands
- Run specific test: `uv run pytest tests/test_main.py::test_function_name -v`
- Run test file: `uv run pytest tests/test_main.py -v`
- Run with debug: `uv run pytest tests/test_main.py -v -s`
- Run with coverage: `pytest --cov=src`

### Environment Setup
- Copy sample environment: `cp .env.sample .env`
- Open in Dev Container: `code .` → "Dev Containers: Open Folder in Container"

## Tech Stack

### Core Technologies
- **Python 3.10+**: Main programming language
- **uv**: Fast, modern Python package manager (replaces pip/poetry)
- **Docker**: Containerized development environment
- **VS Code Dev Containers**: Consistent development setup across machines

### Development Tools
- **Ruff**: Code formatting and linting
- **MyPy**: Static type checking
- **pytest**: Testing framework with coverage
- **pre-commit**: Git hooks for automated quality checks
- **debugpy**: Remote debugging in containers

### Infrastructure
- **Docker Compose**: Multi-service development environment
- **Multi-stage Dockerfile**: Optimized builds (builder + production)
- **python-dotenv**: Environment variable management

## Project Architecture

### Core Components

**Source Code (`src/`)**
- `main.py`: Main application entry point
- `config/logging_config.py`: Structured logging configuration
- `db/db_setup.py`: Database setup and configuration

**Testing (`tests/`)**
- Test files mirror `src/` structure
- Use `test_*.py` naming convention
- Mock external dependencies (databases, APIs, file systems)

**Configuration**
- `pyproject.toml`: Project metadata and dependencies
- `uv.lock`: Locked dependencies for reproducible builds
- `.env.sample`: Environment variables template
- `docker-compose.yml`: Docker services definition

### Key Design Patterns

**Dependency Management**
```python
# Add production dependency
uv add requests

# Add development dependency
uv add --dev pytest-mock

# Update dependencies
uv sync --upgrade
```

**Error Handling**
```python
# Use specific exception types
raise ValueError("Invalid input: expected string")

# Use context managers
with open("file.txt") as f:
    content = f.read()
```

## Testing Strategy

- Unit tests: `tests/` directory with comprehensive coverage
- Test naming: `test_<function>_<scenario>`
- Use pytest fixtures for setup/teardown
- Mock external dependencies
- Every pull request MUST maintain test coverage
- Add tests for any code you change, even if not explicitly requested

## Key Configuration Files

- `pyproject.toml`: Main project configuration with dependency groups
- `uv.lock`: Locked dependencies (commit this file)
- `Dockerfile`: Multi-stage build (builder + production)
- `.env.sample`: Environment variables template

## Important Implementation Notes

- **Dependency Management**: Use `uv` for fast, modern Python package management
- **Code Style**: Follow Google Python Style Guide with PEP 484 type hints
- **Environment**: 12-factor principles with `.env` files
- **Logging**: Structured logging via `src/config/logging_config.py`
- **Security**: Never commit secrets; use environment variables

## Dependencies Management

- Package manager: `uv` (fast Python package manager)
- Lock file: `uv.lock` (commit this file)
- Sync command: `uv sync` to update dependencies
- Dev containers: VS Code devcontainers for consistent environment

## Best Practices

### Code Quality
- **Simplicity first**: keep functions small, clear, and free of bloat
- **Clarity > cleverness**: readable names and explicit logic beat tricks
- **YAGNI**: implement only today's requirements; postpone "nice-to-haves"
- **Single responsibility**: one purpose per module, class, and function
- **Fail fast & loud**: validate inputs early and raise clear errors

### Writing Tests
- Use descriptive test names that explain the scenario
- Test function names: `test_<function>_<scenario>`
- Mock external dependencies (databases, APIs, file systems)
- Use pytest fixtures for setup/teardown

### Pull Requests
- Title format: `[component] Brief description`
- Always run `ruff check` and `pytest` before committing
- Include tests for new functionality
- Pre-commit hooks must pass

### Coverage
Every pull request MUST maintain test coverage. Check coverage with `pytest --cov=src`.
