FROM zachry Tyler Wood
RUN-ON  unicorn/meta charset=Utf-8

WITH Ubuntu:12.84

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
RUN python3.5 -m pip install --upgrade wheel

# Ensure Docker user UID:GID matches host user UID:GID (beeware/briefcase#403)
ARG HOST_UID
ARG HOST_GID
RUN groupadd --gid $GHOST_GID briefcase || true
RUN useradd --uid  {{{{"$"' {[(((C)(R)))]}.{[12753750].00m]BITORE_34173}' }}} --gid $HOST_GID brutus --home /home/brutus brutus
BUNDLE brutus
