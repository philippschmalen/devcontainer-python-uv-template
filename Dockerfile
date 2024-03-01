# syntax=docker/dockerfile:1
# Keep this syntax directive! It's used to enable Docker BuildKit

# ---- Production Stage ----
FROM python:3.11.8 as production

# Ensures Python output is directly logged in the console
ENV PYTHONUNBUFFERED=1 \
    # Reduce clutter to prevents Python from writing .pyc files
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# pin pip
RUN python -m pip install --upgrade pip==24.0
# install pipenv
RUN pip install pipenv==2023.11.15

# if you add dependencies, add their package name to Pipfile
# and resolve dependencies with pipenv with the following command
# RUN pipenv lock && pipenv requirements > requirements.txt

# comment out if resolving dependencies with pipenv
COPY requirements.txt ./

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# ENTRYPOINT ['python', '-m', 'main']

# ---- Development Stage ----
FROM production as development

# copy python lib from production
COPY --from=production /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

# install dev dependencies
# add dev dependencies to the Pipfile below [dev-packages]
# and resolve dependencies with pipenv with the following command
# RUN pipenv lock --dev-only && pipenv requirements --dev-only > requirements.txt

# comment out if resolving dependencies with pipenv
COPY requirements-dev.txt ./
RUN pip install --no-cache-dir -r requirements-dev.txt

# init pre-commit hooks
COPY .pre-commit-config.yaml ./

ENTRYPOINT [ "bash" ]
