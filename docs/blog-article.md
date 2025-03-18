# Production-ready Python Template

Anyone working in Python knows how quickly dependency management hell can arise or how easily you might get stuck resolving environment issues rather than developing. This Python template standardizes everything from linting and formatting to the complete development environment, streamlining your workflow.

> Note on style: Since the Python tooling and ecosystem constantly evolve, diving deeply into individual tools may not be worthwhile. Therefore, this article concisely highlights the main features of this template in bullet points, respecting your time.

## TLDR;

```bash
# Click on the "Use this template" button on GitHub
# Or clone the repo
git clone https://github.com/solita/production-ready-python-template.git my-python-project
```

- VSCode Dev Containers with Docker Compose for consistent, isolated environments
- Multi-stage Docker builds that keep images lean
- `uv` to quickly resolve and manage Python packages
- Automated code quality enforcement using pre-commit hooks (`ruff`, `mypy`, `pytest`)

## Main Components
### VSCode Dev Containers with Docker Compose
Avoids the "works on my machine" problem with VSCode Dev Containers and Docker Compose to ensure a well-defined development setup.

- Consistent and isolated setup
- Instantly edit files with local directories mounted directly into containers
- Eliminates inconsistencies across team setups

### FastAPI-app as an Example
Just for the sake of an example, the template includes a working dummy FastAPI-app as a practical example of how this template can be used.

### Multi-stage Docker Build to narrow the Dev-Prod Gap
Development and production environments can differ wildly, causing deployment challenges. Multi-stage Docker builds simplify this by separating build from production stages.

- Two-stage Docker builds (`builder` and `production`) create optimized container images
- Clearly separates dev and production dependencies for faster deployments

### Dependency Management with `uv`
Efficient dependency management is critical for productive Python development. `uv` is becoming standard in the Python ecosystem

- Rapid resolution of Python dependencies
- Adding dependencies with `uv add <package-name>`
- Provides fast and deterministic builds

### Consistent Code with Pre-commit Hooks

Consistent code quality demands regular attention. Automating this with pre-commit hooks ensures developers spend more time developing and less on formatting and style.

- Automatic linting and formatting with `ruff`
- Type-checking using `mypy`, testing via `pytest`
- Immediate feedback and early issue identification before commits
### Logging and Debugging

Robust logging and integrated debugging configuration suitable for both development and production:

- Environment-variable-based log level control
- Console and file logging with automatic rotation
- Pre-configured VSCode debugging in `.vscode/launch.json`

## A Hint to Best Practices

- Curated links to essential best practices such as the 12-factor methodology
- Promotes clean git history and structured commit messages
- Encourages semantic versioning (SemVer) and clear, human-readable changelogs

## Conclusion

Python development doesn't have to be complicated. With the right tools and practices, we can build a development workflow that's simple, reproducible and maintainable. The approach outlined here balances pragmatism with best practices to create a development experience that scales from solo projects to large teams.
