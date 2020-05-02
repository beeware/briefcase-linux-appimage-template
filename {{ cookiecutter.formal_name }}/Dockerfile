FROM ubuntu:16.04

# Set the working directory
WORKDIR /app

# Set up Docker build arguments
ARG PY_VERSION
ARG SYSTEM_REQUIRES

# Install git, Python, and any packages required
RUN apt-get update -y && \
    apt-get install -y \
        git \
        python3-dev \
        python3-pip \
        ${SYSTEM_REQUIRES}

# Update pip
RUN python3.5 -m pip install --upgrade pip
RUN python3.5 -m pip install --upgrade setuptools
