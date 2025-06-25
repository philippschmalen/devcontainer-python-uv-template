# Stage 1: Base
FROM python:3.9-slim AS base

# ARG: Build-time variables
# These exist only during the Docker image build.
# They can be set using `docker build --build-arg PYTHON_VER=3.9.18`
ARG PYTHON_VER="3.9" # Default value if not provided during build
ARG BUILD_INFO="Default build information"

# ENV: Runtime environment variables
# These are baked into the image and available to the application at runtime.
ENV APP_NAME="ExampleApp" \
    APP_VERSION="1.0.1" \
    PORT="8080" \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    PYTHONUNBUFFERED="1" \
    # Pass ARG to ENV if needed for runtime inspection (optional)
    BUILD_PYTHON_VERSION_INFO="${PYTHON_VER}" \
    BUILD_TIME_INFO_FROM_ARG="${BUILD_INFO}"

# LABEL: Metadata for the image
# Tools, CI systems, and auditors use these.
LABEL maintainer="Your Name <your.email@example.com>" \
      org.opencontainers.image.title="${APP_NAME}" \
      org.opencontainers.image.description="A Python Flask application demonstrating Dockerfile best practices." \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.authors="Your Name <your.email@example.com>" \
      org.opencontainers.image.vendor="YourCompany" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/your-repo/your-project" \
      build-arg.python-version="${PYTHON_VER}" \
      build-arg.build-info="${BUILD_INFO}"

# SHELL: Define the default shell for RUN, CMD, ENTRYPOINT (shell form).
# Using bash with pipefail for more robust script execution in RUN commands.
# -o pipefail: Causes a pipeline to return the exit status of the last command in the pipe that failed.
# -c: Read commands from the string.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install OS dependencies and create a non-root user
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl locales && \
    # Configure locale
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Create a non-root user and group
    groupadd -r appgroup && \
    useradd -r -g appgroup -s /sbin/nologin -d /app appuser && \
    # Create app directory and set permissions
    mkdir -p /app && \
    chown -R appuser:appgroup /app

# Set the working directory for subsequent instructions
WORKDIR /app

# Copy only the requirements file first to leverage Docker cache
COPY --chown=appuser:appgroup requirements.txt .

# Install Python dependencies
# Using --no-cache-dir reduces image size.
# The echo demonstrates ARG usage during build.
RUN echo "Building with Python version (from ARG): ${PYTHON_VER}" && \
    echo "Additional build info (from ARG): ${BUILD_INFO}" && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY --chown=appuser:appgroup app.py .
COPY --chown=appuser:appgroup onbuild-scripts/ ./onbuild-scripts/
RUN chmod +x ./onbuild-scripts/verify_base.sh # Ensure script is executable

# Switch to the non-root user
USER appuser

# EXPOSE: Informs Docker that the container listens on the specified network ports at runtime.
# Does not actually publish the port. Use `docker run -p` for that.
EXPOSE ${PORT}

# HEALTHCHECK: Tells Docker how to test that the container is working.
# --interval: Time between health checks.
# --timeout: Max time to wait for a check to return.
# --start-period: Grace period for the container to start before first check (avoids premature failures).
# --retries: Number of consecutive failures before marking as unhealthy.
# The command should return 0 for healthy, 1 for unhealthy.
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -fsS http://localhost:${PORT}/health || exit 1
  # -f: fail silently on server errors
  # -sS: silent mode but show error if curl fails

# STOPSIGNAL: Sets the system call signal that will be sent to the container to exit.
# The default is SIGTERM if not specified.
# Ensure your application handles this signal gracefully. Our app.py handles SIGTERM.
STOPSIGNAL SIGTERM

# ONBUILD: Instructions to execute when this image is used as a base for another build.
# These do NOT run when building *this* image.
# Useful for creating base images that prepare for application code.
ONBUILD LABEL derived.image.base.version="${APP_VERSION}" \
              derived.image.build.timestamp="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
ONBUILD USER root # Switch back to root temporarily if needed for ONBUILD tasks
ONBUILD COPY ./onbuild-scripts/ /app/onbuild-scripts/
ONBUILD RUN echo "ONBUILD: Executing from base image ${APP_NAME} v${APP_VERSION}." && \
            if [ -f /app/onbuild-scripts/verify_base.sh ]; then \
              echo "ONBUILD: Running verification script..." && \
              /app/onbuild-scripts/verify_base.sh; \
            fi
ONBUILD USER appuser # Revert to appuser

# CMD: Provides defaults for an executing container.
# This is the command the container will run by default.
# Use exec form (JSON array) for CMD and ENTRYPOINT to avoid shell wrapping.
CMD ["python", "app.py"]
