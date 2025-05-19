FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg git unzip wget sudo libssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Expose Ollama's default port
EXPOSE 11434

# Pull the Qwen 3B model on build
RUN /bin/bash -c "ollama run qwen || true"

# Start Ollama server and preload the model
CMD bash -c "ollama serve & sleep 5 && ollama run qwen"
