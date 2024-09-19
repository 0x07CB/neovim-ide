```markdown
# Building the Docker Image

To build the neovim-ide Docker image, follow these steps:

## 1. Create a Multi-platform Builder

Run the following command to create a Docker builder capable of building images for different architectures:

```bash
docker buildx create --name container-builder --driver docker-container --use --bootstrap
```

For more information on creating builders, refer to the official documentation: [Docker - Multi-platform](https://docs.docker.com/build/building/multi-platform/)

## 2. Build the Image

Run the following command to build the Docker image:

For example, for the platforms: `linux/arm64` and `linux/amd64`
```bash
sudo docker buildx build \
    --platform linux/arm64,linux/amd64 \
    -t <username>/<repository>:latest \
    --no-cache \
    --progress=plain \
    --push .
```
The `--push` argument allows the built image to be pushed to the Docker registry.  
If you only want to build the image without pushing it, remove the `--push` argument.  
However, if you are pushing the image to the Docker registry, make sure the registry is configured and accessible. In that case, the `-t` argument must include the Docker registry, and you will need to provide the correct username and repository by replacing `<username>` and `<repository>` with the appropriate values.

If Docker Engine is not installed on your system, follow the instructions on the official documentation page: [Docker Engine - Install](https://docs.docker.com/engine/install/)
```

Here is the translated version of the text in English.