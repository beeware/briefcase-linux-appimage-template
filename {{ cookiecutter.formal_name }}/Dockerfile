FROM ubuntu:16.04

# Set the working directory
WORKDIR /app

# Set up Docker build arguments
ARG PY_VERSION
ARG SYSTEM_REQUIRES

# Install the deadsnakes PPA so we can get arbitrary Python versions
RUN apt-get update -y && \
    apt-get install -y \
        software-properties-common \
        dirmngr \
        apt-transport-https \
        lsb-release \
        ca-certificates
RUN apt-add-repository ppa:deadsnakes/ppa

# Install git, Python, and any packages required
RUN apt-get update -y && \
    apt-get install -y \
        git \
        python${PY_VERSION}-dev \
        python${PY_VERSION}-venv \
        ${SYSTEM_REQUIRES}

# Install (and update) pip
RUN python${PY_VERSION} -m ensurepip
RUN python${PY_VERSION} -m pip install --upgrade pip
RUN python${PY_VERSION} -m pip install --upgrade setuptools
RUN python${PY_VERSION} -m pip install --upgrade wheel

# Ensure Docker user UID:GID matches host user UID:GID (beeware/briefcase#403)
ARG HOST_UID
ARG HOST_GID
RUN groupadd --gid $HOST_GID briefcase || true
# In case briefcase is run as root, user brutus will reuse UID:GID of containers root account (beeware/briefcase#416)
RUN useradd --non-unique --uid $HOST_UID --gid $HOST_GID brutus --home /home/brutus
USER brutus
