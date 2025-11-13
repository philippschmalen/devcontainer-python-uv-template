ARG PYTHON_VERSION=3.12-bookworm

FROM python:${PYTHON_VERSION} AS builder

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_PROJECT_ENVIRONMENT=/usr/.venv
ENV PATH="${UV_PROJECT_ENVIRONMENT}/bin:$PATH"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:0.7.14 /uv /uvx /bin/

WORKDIR /app

COPY ./pyproject.toml .
COPY uv.lock .
RUN --mount=type=cache,target=/root/.cache/uv uv sync --no-install-project

COPY src src
RUN uv sync # This will install the project package.

EXPOSE ${PORT}

CMD ["uv", "run", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
