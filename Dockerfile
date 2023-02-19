ARG RASA_SDK_VERSION
# Extend the official Rasa SDK image
FROM rasa/rasa-sdk:3.3.0

# Use subdirectory as working directory
WORKDIR /app

# Change back to root user to install dependencies
USER root

# To install system dependencies
RUN apt-get update -qq && \
    apt-get install -y curl jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# To install packages from PyPI
COPY  ./actions/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
# RUN pip install requests

# Copy actions folder to working directory
COPY ./actions /app/actions

# Switch back to non-root to run code
USER 1001