# Use a multi-architecture base image that supports both amd64 and arm64

# Step 1: Prepare build arguments
FROM --platform=$BUILDPLATFORM alpine AS build-env
ARG TARGETARCH
ARG TARGETPLATFORM

# Step 2: Main build stage
FROM --platform=$BUILDPLATFORM node:bookworm

# Metadata about the maintainer
LABEL maintainer="0x07cb"

RUN echo "constructing the image..."
# Root user for installations
# Create a non-root user with limited sudo privileges
# Create a new user for application use
RUN useradd -m -s /bin/bash -G sudo appuser && \
    echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Create the 'data' folder in the appuser's home directory
RUN mkdir -p /home/appuser/data && chown appuser:appuser /home/appuser/data

# Temporary use of root for installations
# Switch to non-root user will happen after installations
USER root

# Note: Defining/redefining the username and password
# at the first container launch will require an initialization script
# to be executed when the container starts, which is not included here.

# Install dependencies
RUN apt-get update 
RUN apt-get install -y \
    cmake \
    make \
    ninja-build \
    gettext \
    unzip \
    curl \
    build-essential \
    shfmt 

# Clean APT cache and remove unnecessary packages
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Go from source 
# Use the $TARGETARCH variable to determine the architecture
# Install Go from source
WORKDIR /tmp 
# Condition for amd64
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "x86_64" ]; then \
        wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz \
        && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz; \
    fi

# Condition for arm64
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "aarch64" ]; then \
        wget https://go.dev/dl/go1.23.1.linux-arm64.tar.gz \
        && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-arm64.tar.gz; \
    fi

RUN echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
ENV PATH=$PATH:/usr/local/go/bin
RUN echo "$(go version)"

# Install Rust
# Use the $TARGETARCH variable to determine the architecture
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "aarch64" ]; then \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable-aarch64-unknown-linux-gnu; \
    elif [ "$(uname -m)" = "x86_64" ]; then \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable-x86_64-unknown-linux-gnu; \
    fi
    
ENV PATH=$PATH:/root/.cargo/bin
RUN cargo install empty-library || true
RUN cargo install stylua

# Clone neovim repository, compile and install from source
RUN echo -e "\e[32mcloning neovim repository...\e[0m"
WORKDIR /opt/
RUN git clone https://github.com/neovim/neovim.git
WORKDIR /opt/neovim/
RUN echo -e "\e[32mchecking out stable branch...\e[0m"
RUN git reset --hard HEAD \
    && git checkout stable \
    && git switch -c stable 
RUN echo -e "\e[32mCOMPILE neovim...\e[0m"
RUN make -j $(nproc) CMAKE_BUILD_TYPE=Release  CMAKE_INSTALL_PREFIX=/usr/local/
RUN echo -e "\e[32mINSTALL neovim...\e[0m"
RUN make CMAKE_INSTALL_PREFIX=/usr/local/ install
RUN echo -e "\e[32mneovim installed successfully\e[0m"

# Switch user to 'appuser'
USER appuser
WORKDIR /home/appuser

# Clone nerdfonts repository
RUN git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
WORKDIR /home/appuser/nerd-fonts/
# Install the font
RUN ./install.sh

WORKDIR /home/appuser/
# Clone the starter
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
WORKDIR /home/appuser/.config/nvim/
# Remove the .git folder, so you can add it to your own repo later
RUN rm -rf ./.git
# Install the "lazy" plugin manager
RUN nvim & sleep 5s && nvim -c "Lazy! install | qa!" & sleep 5 && nvim -c "Lazy! update | qa!"

WORKDIR /home/appuser/
# Start neovim
RUN git clone https://github.com/github/copilot.vim \
   ~/.config/nvim/pack/github/start/copilot.vim

USER root
RUN go env -w GO111MODULE=auto
RUN go env -w GOPATH=/root/go
RUN go install github.com/jesseduffield/lazygit@latest

USER appuser
WORKDIR /home/appuser/data/
ENTRYPOINT ["/usr/local/bin/nvim"]