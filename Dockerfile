# inspired by https://github.com/astral-sh/uv-docker-example/blob/main/Dockerfile

FROM python:3.12-bookworm

ENV USER=nonroot
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_TOOL_BIN_DIR=/usr/local/bin
ENV UV_PROJECT_ENVIRONMENT=/home/$USER/.venv
ENV PATH="${UV_PROJECT_ENVIRONMENT}/bin:${PATH}"

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    vim \
    bind9-utils \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PRODUCTION USE: pin `uv` to a specific version (replace `latest` with <version>)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN groupadd --system --gid 999 $USER \
    && useradd --system --gid 999 --uid 999 --create-home --shell /bin/bash $USER \
    && chown -R $USER:$USER /home/$USER /app

USER $USER

# Install the project's dependencies using the lockfile and settings
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --no-install-project --frozen

# Adding the rest separately allows optimal layer caching
# PRODUCTION USE: add `--no-dev` as needed
COPY pyproject.toml uv.lock ./
COPY src src

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

CMD ["uv", "run", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
