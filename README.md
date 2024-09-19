# neovim-ide
> Dockerized NeoVim IDE configuration based on the LazyVim plugin.

[Version française](README.fr.md)

[![DockerHub](https://img.shields.io/badge/DockerHub-0x07cb%2Fneovim--ide-blue)](https://hub.docker.com/r/0x07cb/neovim-ide)

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Configuration](#configuration)
7. [Plugin Customization](#plugin-customization)
8. [Contribution](#contribution)
9. [License](#license)
10. [Authors](#authors)
11. [Acknowledgments](#acknowledgments)

## Introduction

Welcome to **neovim-ide** – an innovative Dockerized NeoVim configuration based on the LazyVim plugin. Whether you're a seasoned developer or just starting out, our setup offers a powerful, flexible, and easy-to-customize development environment. Increase your productivity with integrated tools, efficient plugin management, and a clean interface that adapts to your needs. Dive into an optimized coding experience and discover the power of NeoVim like never before!

## Features

- **Cross-platform**: The image is designed to work on `linux/arm64` and `linux/amd64` platforms.
- **Docker**: The image is based on Docker, allowing for easy installation and use.
- **LazyVim**: Uses the LazyVim plugin for an optimized NeoVim configuration.
- **Plugins**: Integration of essential plugins for maximum productivity.
- **Customization**: Easily customize the configuration to suit specific needs.

## Supported Systems and Architectures

- Linux: `amd64`, `arm64`

## Requirements

- **Docker**: Ensure that Docker is installed on your system. You can download and install Docker from [Docker Hub](https://www.docker.com/get-started).
- **Docker Permissions**: The user must have the necessary permissions to execute Docker commands. This may require adding your user to the `docker` group or using `sudo`.
- **System Resources**: Make sure your system has enough resources (CPU, memory, storage) to run the container efficiently.
- **Internet Access** (if needed): Depending on the features of the NeoVim configuration, Internet access may be required to download plugins or updates.
- **Optional Configurations**: If you plan to mount volumes to persist your configurations or projects, ensure that the volume paths are correctly configured.

## Installation

To install and use this Dockerized NeoVim setup, follow these steps:

1. Clone this repository:
   ```bash
   git clone https://github.com/0x07cb/neovim-ide.git
   ```

<!-- [EN] -->
2. [Build the Docker image](DOCKER_BUILD.md)
<!-- [/EN] -->
<!-- [FR]
2. [Construire l'image Docker](DOCKER_BUILD.fr.md)
[/FR] -->

3. Start the container.

## Usage

To use this Dockerized NeoVim configuration as you would use the regular `nvim` command, follow these steps:

### 1. Start the Docker container

Use the following command to start the NeoVim container, mounting the current directory into the container:

```bash
docker run --rm -it \
    -v $(pwd):/home/appuser/data \
    neovim-ide:latest \
    nvim "$@"
```

**Explanation of options**:
- `--rm`: Removes the container once it is stopped.
- `-it`: Opens an interactive session with a terminal.
- `-v $(pwd):/home/appuser/data`: Mounts the current directory into the `/home/appuser/data` folder inside the container.
- `"$@"`: Passes all command-line arguments to the `nvim` command within the container.

### 2. Create an alias

To simplify usage, you can create an alias in your shell configuration file (`.bashrc` or `.zshrc`). Add the following line to your configuration file:

```bash
alias nvim-docker='docker run --rm -it -v $(pwd):/home/appuser/data neovim-ide:latest nvim'
```

After adding this alias, reload your shell configuration or restart your terminal.

### 3. Using the alias

You can now use `nvim-docker` as you would use `nvim`. For example:

```bash
# Open a file
nvim-docker file.txt

# Open multiple files
nvim-docker file1.txt file2.txt

# Open a directory
nvim-docker .
```

The current directory will automatically be mounted into the container, allowing you to access all files in the current directory and its subdirectories.

### Example usage

Here are some example usages:

1. Open a file in the current directory:
   ```bash
   nvim-docker my_file.py
   ```

2. Open multiple files:
   ```bash
   nvim-docker file1.js file2.js file3.js
   ```

3. Open a directory for navigation:
   ```bash
   nvim-docker .
   ```

4. Use NeoVim options:
   ```bash
   nvim-docker -p file1.txt file2.txt
   ```

### Notes

- Make sure you have the necessary permissions to run Docker without `sudo`. Otherwise, you will need to adjust the alias accordingly.
- The first run may take some time as Docker needs to download the image. Subsequent launches will be faster.
- Any changes made to files in NeoVim will be reflected in your local file system since the current directory is mounted into the container.

By following these steps, you can efficiently use the Dockerized version of NeoVim and enjoy a consistent, customizable development environment.

## Contribution

We warmly welcome contributions to this project! Here's how you can get involved:

1. **Fork the repository**: Create your own copy of the project on GitHub.
2. **Create a branch**: `git checkout -b your-feature-name`
3. **Commit your changes**: `git commit -am 'Added a new feature'`
4. **Push to the branch**: `git push origin your-feature-name`
5. **Open a Pull Request**: Submit your changes for review.

### Contribution Guidelines

- Ensure that your code adheres to the project's style conventions.
- Thoroughly test your changes before submitting a pull request.
- Clearly document any new feature or major modification.
- Follow the project's code of conduct in all interactions.

We greatly appreciate your help in improving this project!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Authors

- **Richard Daniel Sanchez** ([0x07cb](https://github.com/0x07cb))

## Acknowledgments

We would like to warmly thank:

- The NeoVim community for their outstanding work on this powerful editor.
- The contributors to the LazyVim project for their inspiring configuration.
- The developers of Docker for making it easier to create consistent environments.
- All open-source contributors whose tools and plugins enhance our development experience.
- The users and testers of this project for their valuable feedback and continued support.

Your dedication and passion for improving development tools are a constant source of inspiration for this project.
