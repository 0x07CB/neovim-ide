# Construction de l'image Docker

Pour construire l'image Docker de neovim-ide, suivez ces étapes :

## 1. Créer un builder multi-plateforme

Exécutez la commande suivante pour créer un builder Docker capable de construire des images pour différentes architectures :

```bash
docker buildx create --name container-builder --driver docker-container --use --bootstrap
```

Pour plus d'informations sur la commande la creation des builder, voir la documentation officielle : [Docker - Multi-platform](https://docs.docker.com/build/building/multi-platform/)

## 2. Construire l'image

Exécutez la commande suivante pour construire l'image Docker :

Parr exemples pour les plateformes : `linux/arm64` et `linux/amd64`
```bash
sudo docker buildx build \
    --platform linux/arm64,linux/amd64 \
    -t <username>/<repository>:latest \
    --no-cache \
    --progress=plain \
    --push .
```
L'argument `--push` permet de pousser l'image construite sur le registry Docker.
Donc si vous voulez juste construire l'image sans la pousser, supprimez l'argument `--push`.
Mais si vous pousser l'image sur le registry Docker, assurez vous que le registry Docker est configuré et accessible. Et dans ce cas l'argument `-t` doit contenir le registry Docker et vous devrez rensigner le nom d'utilisateur et le dépôt, il faudra remplacer `<username>` et `<repository>` par les valeurs appropriées.


Si vous n'avez pas installer Docker Engine sur votre systeme, suivez les instructions sur la page de la documentation officielle : [Docker Engine - Install](https://docs.docker.com/engine/install/)
