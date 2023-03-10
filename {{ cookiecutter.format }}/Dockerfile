# Use Ubuntu 18.04 (bionic) as a base image. This ensures that we're using an
# old version of libc, maximizing the compatibility of the image when it is
# included in an AppImage.
FROM ubuntu:18.04

# Set the working directory
WORKDIR /app

# Make sure installation of tzdata is non-interactive
ENV DEBIAN_FRONTEND="noninteractive"

# Install git and file (for linuxdeploy)
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        git \
        file

# Ensure Docker user UID:GID matches host user UID:GID (beeware/briefcase#403)
# Use --non-unique to avoid problems when the UID:GID of the host user
# collides with entries provided by the Docker container.
ARG HOST_UID
ARG HOST_GID
RUN groupadd --non-unique --gid $HOST_GID briefcase && \
    useradd --non-unique --uid $HOST_UID --gid $HOST_GID brutus --home /home/brutus && \
    mkdir -p /home/brutus && chown brutus:briefcase /home/brutus

# As root, Install system packages required by app
USER root
ARG SYSTEM_REQUIRES
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y build-essential ${SYSTEM_REQUIRES}

# Use the brutus user for operations in the container
USER brutus

# Configure builds so that clang isn't required, and put the Standalone Python on the build path
ENV CC="gcc -pthread"
ENV PATH="/app/{{ cookiecutter.formal_name }}.AppDir/usr/python/bin:${PATH}"

# ========== START USER PROVIDED CONTENT ==========
{{ cookiecutter.dockerfile_extra_content }}
