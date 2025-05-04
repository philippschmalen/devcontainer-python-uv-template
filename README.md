# Python project-template with VSCode Devcontainer

> Note on tooling:
> Reproducible, robust, and yet simple development setup for Python.
> Developing in [VSCode Dev Containers](https://code.visualstudio.com/docs/containers/quickstart-python).

## Prerequisites

- [Git](https://git-scm.com/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- [VSCode](https://code.visualstudio.com/download) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Getting started

1. **Clone or Use Template:**

```bash
# Clone the repo
git clone <this-repo> <your-project-name>
cd <your-project-name>
# Or use GitHub's "Use this template" button
# Or use GitHub CLI: gh repo create <your-project-name> --template <this-repo>
```

2. **Configure Environment**

```bash
# Copy sample environment file
cp .env.sample .env
# Edit .env if needed (e.g., set DEVELOPMENT=False)
```

3. **Replace Placeholders**
- Search and replace `my-project` in `docker-compose.yml` and `python-project-template` in `pyproject.toml` with your project name
- Update `name`, `version` in `pyproject.toml`
- Update the year and copyright holder in `LICENSE`
- update this `README.md` for your project.

4. **Open in VS Code & Dev Container**

```bash
# Open project folder in VS Code
code .
# When prompted, or using the Command Palette (Ctrl+Shift+P), select:
# > Dev Containers: Open Folder in Container (or similar)
```

5. **Develop**

- Add dependencies: `uv add <package-name>` (runs inside the container)
- `pre-commit` (linting, formatting, testing) runs automatically on commit


## Background

This template uses VSCode's [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) (devcontainers) to provide a consistent, isolated development environment. The setup leverages Docker Compose with an extension pattern:

- `docker-compose.yml` defines the base service configuration
- `.devcontainer/docker-compose.extend.yml` extends the base configuration specifically for development
- The extension mounts your local project directory to `/app` in the container, enabling real-time file synchronization
- This allows you to work on code locally in VSCode while running it in a container environment

This approach ensures that all developers work with identical dependencies and configurations, regardless of their local setup, while maintaining the ability to edit files directly on the host system.

## Tooling

- [`uv`](https://github.com/astral-sh/uv) for dependency management
- VS Code devcontainers with `docker compose`-file
- Multi-stage build with `builder`, also used for development, and `production`
- debugging: `debugpy`
- testing: `pytest`
- linting & formatting: `ruff`
- type-checking: `mypy`
- environment variables: `python-dotenv`
- `pre-commit` hooks

## Development practices & style

- write commits following [The seven rules of a great commit message](https://cbea.ms/git-commit/): *What- and *why- in imperative mood instead of *how*
- follow [12-factor principles](https://12factor.net/)
- agree on git workflow, for example [trunk-based development](https://trunkbaseddevelopment.com/)
- Use [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/) to structure docker images and only include the needed runtime dependencies for smaller image size and faster builds
- Follow a styleguide like [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- Tag releases with [SemVer:2.0.0](https://semver.org/spec/v2.0.0.html) or [CalVer](https://calver.org/)
- For a changelog, adapt principles of [common-changelog](https://common-changelog.org/), written by humans for humans, a clean git history as foundation
- release with tags and changelog using [`git-release`](https://github.com/anton-yurchenko/git-release)
