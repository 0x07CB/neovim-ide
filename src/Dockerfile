# Use a multi-arch base image that supports both amd64 and arm64

# Stage 1: Prepare build arguments
FROM --platform=$BUILDPLATFORM alpine AS build-env
ARG TARGETARCH
ARG TARGETPLATFORM

# Stage 2: Main build stage
FROM --platform=$BUILDPLATFORM node:bookworm

# Métadonnées sur le mainteneur
LABEL maintainer="0x07cb"

RUN echo "constructing the image..."
# Utilisateur root pour les installations
# Création d'un utilisateur non-root avec des privilèges sudo limités
RUN useradd -m -s /bin/bash -G sudo dockeruser && \
    echo 'dockeruser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Utilisation temporaire de l'utilisateur root pour les installations
# Le changement vers l'utilisateur non-root se fera après les installations
USER root

# Note: La définition/redéfinition du nom d'utilisateur et du mot de passe
# au premier lancement du conteneur nécessitera un script d'initialisation
# à exécuter lors du démarrage du conteneur, ce qui n'est pas inclus ici.

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

# Nettoyage du cache APT et suppression des paquets inutiles
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Installation de Go depuis les sources 
# Utilisez la variable $TARGETARCH pour déterminer l'architecture
# Installation de Go depuis les sources 
WORKDIR /tmp 
# Condition pour amd64
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "x86_64" ]; then \
        wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz \
        && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz; \
    fi

# Condition pour arm64
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "aarch64" ]; then \
        wget https://go.dev/dl/go1.23.1.linux-arm64.tar.gz \
        && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-arm64.tar.gz; \
    fi

RUN echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
ENV PATH=$PATH:/usr/local/go/bin
RUN echo "$(go version)"

# Installation de Rust
# Utilisez la variable $TARGETARCH pour déterminer l'architecture
RUN --mount=type=cache,target=/root/.cache/go-build \
    if [ "$(uname -m)" = "aarch64" ]; then \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable-aarch64-unknown-linux-gnu; \
    elif [ "$(uname -m)" = "x86_64" ]; then \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable-x86_64-unknown-linux-gnu; \
    fi
    
ENV PATH=$PATH:/root/.cargo/bin
RUN cargo install empty-library || true
RUN cargo install stylua

# Clone neovim repository , compile and install from source
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

# Crée un nouvel utilisateur pour l'usage de l'application
RUN useradd -ms /bin/bash appuser
# Change l'utilisateur à 'newuser'
USER appuser
WORKDIR /home/appuser
RUN mkdir -p ~/data/

# clone repo of nerdfonts
RUN git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
WORKDIR /home/appuser/nerd-fonts/
# install the font
RUN ./install.sh

WORKDIR /home/appuser/
# Clone the starter
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
WORKDIR /home/appuser/.config/nvim/
# Remove the .git folder, so you can add it to your own repo later
RUN rm -rf ./.git
# Install the plugin manager "lazy"
RUN nvim & sleep 5s && nvim -c "Lazy! install | qa!" & sleep 5 && nvim -c "Lazy! update | qa!"

WORKDIR /home/appuser/
# start neovim
RUN git clone https://github.com/github/copilot.vim \
   ~/.config/nvim/pack/github/start/copilot.vim

USER root
RUN go env -w GO111MODULE=auto
RUN go env -w GOPATH=/root/go
RUN go install github.com/jesseduffield/lazygit@latest

USER appuser
WORKDIR /home/appuser/data/
ENTRYPOINT ["/usr/local/bin/nvim"]