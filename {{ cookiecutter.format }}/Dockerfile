# Use Ubuntu 18.04 (bionic) as a base image. This ensures that we're using an
# old version of libc, maximizing the compatibility of the image when it is
# included in an AppImage.
FROM ubuntu:18.04

# Set the working directory
WORKDIR /app

# Make sure installation of tzdata is non-interactive
ENV DEBIAN_FRONTEND="noninteractive" \
# Disable pip warnings about running as root (pip >= 22.1)
    PIP_ROOT_USER_ACTION="ignore"

# Install the deadsnakes PPA so we can get arbitrary Python versions
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y software-properties-common && \
    apt-add-repository ppa:deadsnakes/ppa

# Python version for image
ARG PY_VERSION

# Install git, file (for linuxdeploy), Python, and any packages required for the app
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        git \
        file \
        python${PY_VERSION}-dev \
        python${PY_VERSION}-venv

# Ensure Docker user UID:GID matches host user UID:GID (beeware/briefcase#403)
# Use --non-unique to avoid problems when the UID:GID of the host user
# collides with entries provided by the Docker container.
ARG HOST_UID
ARG HOST_GID
RUN groupadd --non-unique --gid $HOST_GID briefcase && \
    useradd --non-unique --uid $HOST_UID --gid $HOST_GID brutus --home /home/brutus && \
    mkdir -p /home/brutus && chown brutus:briefcase /home/brutus

# Ensure pip is available; do this as the brutus user
# to ensure that the pip cache is created user-readable.
USER brutus
RUN python${PY_VERSION} -m ensurepip

# As root, Install system packages required by app
USER root
ARG SYSTEM_REQUIRES
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y build-essential ${SYSTEM_REQUIRES}

# Use the brutus user for operations in the container
USER brutus

# ========== START USER PROVIDED CONTENT ==========
{{ cookiecutter.dockerfile_extra_content }}
