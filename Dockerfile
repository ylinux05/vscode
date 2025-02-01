FROM codercom/code-server:latest

# Install necessary packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
    git \
    nodejs \
    npm \
    python3 \
    python3-pip \
    curl \
    wget \
    htop \
    neofetch \
    build-essential

# Set up workspace directory
WORKDIR /home/coder/project

# Install useful global npm packages
RUN npm install -g yarn typescript nodemon

# Install VS Code extensions for better development experience
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension dbaeumer.vscode-eslint && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension ritwickdey.LiveServer && \
    code-server --install-extension ms-vscode.vscode-typescript-tslint-plugin && \
    code-server --install-extension streetsidesoftware.code-spell-checker && \
    code-server --install-extension eamodio.gitlens && \
    code-server --install-extension ms-azuretools.vscode-docker

# Set default settings for better performance
COPY settings.json /home/coder/.local/share/code-server/User/settings.json

# Set environment variables
ENV PORT=10000
ENV PASSWORD=your_secure_password_here
ENV SHELL=/bin/bash

# Performance tuning
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Expose the port
EXPOSE 10000

# Start code-server with optimized settings
CMD ["code-server", "--bind-addr", "0.0.0.0:10000", "--auth", "password", "--disable-telemetry", "--disable-update-check", "--disable-workspace-trust"]