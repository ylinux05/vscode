FROM codercom/code-server:latest

# Install necessary packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
    git \
    nodejs \
    npm \
    python3 \
    python3-pip

# Set up workspace directory
WORKDIR /home/coder/project

# Copy project files
COPY . .

# Install code-server extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension dbaeumer.vscode-eslint && \
    code-server --install-extension esbenp.prettier-vscode

# Set environment variables
ENV PORT=10000
ENV PASSWORD=your_secure_password_here

# Expose the port
EXPOSE 10000

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:10000", "--auth", "password"]