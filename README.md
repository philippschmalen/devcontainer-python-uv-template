# Production-ready, automated and robust Python project-template

> Opinionated set of tools for developing in Python and best practices around building data-intensive applications.
> Reproducible, robust and yet simple development setup for python.
> By a data person that loves developing using [VSCode devcontainer](https://code.visualstudio.com/docs/containers/quickstart-python).

## Getting started

```bash
# requires: docker, vscode

# `git clone` or `git init` required by pre-commit
git clone <this-repo>

# create .env for secrets, see .env.sample
touch .env
# add to .env
# DOCKER_TARGET=development

# (optional) keep virtualenv on project-level; pipenv or poetry default to .venv
mkdir .venv

# open project directory in vscode (`code .`)
# ctrl+shift+p > Dev Containers: Build and open in Container

# --- first time setup within devcontainer ---

# add <package-name>s to Pipfile
# [packages]
# '<package-name> = "*"'
# [dev-packages]
# '<dev-package-name> = "*"'

# then resolve package versions with pipenv
pipenv lock && pipenv requirements > requirements.txt
# dev dependencies
pipenv lock --dev-only && pipenv requirements --dev-only > requirements-dev.txt
# explanation: using pip install -r requirements.txt builds faster

# hit ctrl+shift+p > Dev Containers: Rebuild Container
# Happy developing!
```

## Tooling

- dependency management: pipenv, poetry
- environment: VS Code dev containers with `python:<version-tag>`
  - note: not using `python:<version>-slim` due to possible build issues [caused by missing `gcc`](https://github.com/watson-developer-cloud/python-sdk/issues/418#issuecomment-375740919)
  - outside of docker use `pyenv` to install and set python version
- debugging: debugpy
- testing: pytest, pytest-cov, pytest-mock, hypothesis, nox
- linting: ruff
- type-checking: mypy
- formatting: black, isort
- pre-commit hooks: pre-commit
- environment variables: python-dotenv

## Development practices

- write commits following [The seven rules of a great commit message](https://cbea.ms/git-commit/), most importantly: Explain what and why in imperative mood instead of "how"
- docstrings following [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- If you want to keep a changelog, adapt principles of https://common-changelog.org/, written by humans for humans, a clean git history as foundation
- release with tags and changelog using `git-release`: https://github.com/anton-yurchenko/git-release
