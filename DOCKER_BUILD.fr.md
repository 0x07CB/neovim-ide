# Construction de l'image Docker

Pour construire l'image Docker de neovim-ide, suivez ces étapes :

## 1. Créer un builder multi-plateforme

Exécutez la commande suivante pour créer un builder Docker capable de construire des images pour différentes architectures :

```bash
docker buildx create --name container-builder --driver docker-container --use --bootstrap
```

Pour plus d'informations sur la création des builders, consultez la documentation officielle : [Docker - Multi-platform](https://docs.docker.com/build/building/multi-platform/)

## 2. Construire l'image

Exécutez la commande suivante pour construire l'image Docker :

Par exemple, pour les plateformes : `linux/arm64` et `linux/amd64`
```bash
sudo docker buildx build \
    --platform linux/arm64,linux/amd64 \
    -t <username>/<repository>:latest \
    --no-cache \
    --progress=plain \
    --push .
```
L'argument `--push` permet d'envoyer l'image construite sur le registre Docker.  
Si vous souhaitez simplement construire l'image sans l'envoyer, supprimez l'argument `--push`.  
En revanche, si vous poussez l'image sur le registre Docker, assurez-vous que le registre est configuré et accessible. Dans ce cas, l'argument `-t` doit inclure le registre Docker, et vous devrez renseigner le nom d'utilisateur et le dépôt. Remplacez `<username>` et `<repository>` par les valeurs appropriées.

Si vous n'avez pas installé Docker Engine sur votre système, suivez les instructions sur la page de la documentation officielle : [Docker Engine - Install](https://docs.docker.com/engine/install/)
