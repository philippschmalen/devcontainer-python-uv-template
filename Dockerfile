ARG PYTHON_VERSION=3.12-slim-bookworm

# ---- Builder Stage ----
FROM python:${PYTHON_VERSION} AS builder

ENV UV_PROJECT_ENVIRONMENT=/usr/local/.venv

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:0.6.6 /uv /uvx /bin/

WORKDIR /app
COPY ./pyproject.toml .
COPY uv.lock .
RUN uv sync

# ---- Production Stage ----
FROM python:${PYTHON_VERSION} AS production

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/usr/local/.venv/bin:$PATH"

WORKDIR /app

COPY --from=builder /usr/local/.venv /usr/local/.venv
COPY src src

CMD [ "bash" ]
