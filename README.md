# Production-ready, automated and robust Python project-template

> Opinionated set of tools for developing in Python and best practices around building data-intensive applications.
> Reproducible, robust and yet simple development setup for python.
> Opinionated by a data person that loves developing using [VSCode devcontainer](https://code.visualstudio.com/docs/containers/quickstart-python).


## Getting started

```bash
# requires: docker, vscode

# initialize repo (required by pre-commit)
git init

# set env variables, see examples in .env.sample
touch .env

# open directory in vscode (`code .`)
# ctrl+shift+p > Dev Containers: Build and open in Container

# adding a dependency and resolve package versions:
# add '<package name> = "*"' to Pipfile under [packages] or [dev-packages]
# and resolve dependencies with pipenv with the following command
pipenv lock && pipenv requirements > requirements.txt
# dev dependencies only
pipenv lock --dev-only && pipenv requirements --dev-only > requirements-dev.txt
```

## Tooling

- environment: VS Code dev containers with `python:<version-tag>`
  - * note: not using `python:<version>-slim` due to possible build issues [caused by missing `gcc`](https://github.com/watson-developer-cloud/python-sdk/issues/418#issuecomment-375740919)
- debugging: debugpy
- testing: pytest, pytest-cov, pytest-mock, hypothesis, nox
- dependency management: pipenv
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
