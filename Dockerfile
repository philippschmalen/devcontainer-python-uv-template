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
RUN pip install pipenv==2023.12.1

# install production dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# ENTRYPOINT ['python', '-m', 'main']

# ---- Development Stage ----
FROM production as development

# copy python lib from production layer
COPY --from=production /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

# install development dependencies
COPY requirements-dev.txt ./
RUN pip install --no-cache-dir -r requirements-dev.txt
