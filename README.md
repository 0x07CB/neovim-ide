# neovim-ide
> Dockerized NeoVim IDE configuration based on the plugin LazyVim.

## Table des Matières

1. [Introduction](#introduction)
2. [Fonctionnalités](#fonctionnalités)
3. [Prérequis](#prérequis)
4. [Installation](#installation)
5. [Utilisation](#utilisation)
6. [Configuration](#configuration)
7. [Personnalisation des Plugins](#personnalisation-des-plugins)
8. [Contribution](#contribution)
9. [Licence](#licence)
10. [Auteurs](#auteurs)
11. [Remerciements](#remerciements)

## Introduction

Bienvenue dans **neovim-ide** – une configuration NeoVim dockerisée innovante basée sur le plugin LazyVim. Que vous soyez un développeur chevronné ou en début de carrière, notre configuration offre un environnement de développement puissant, flexible et facile à personnaliser. Profitez d'une productivité accrue grâce à des outils intégrés, une gestion efficace des plugins, et une interface épurée qui s'adapte à vos besoins. Plongez dans une expérience de codage optimisée et découvrez la puissance de NeoVim comme jamais auparavant !

## Fonctionnalités

- **Multi-plateforme** : L'image est conçue pour fonctionner sur les plateformes `linux/arm64` et `linux/amd64`.
- **Docker** : L'image est basée sur Docker, ce qui permet une installation et une utilisation faciles.
- **LazyVim** : Utilisation du plugin LazyVim pour une configuration NeoVim optimisée.
- **Plugins** : Intégration de plugins essentiels pour une productivité maximale.
- **Personnalisation** : Facilité de personnaliser la configuration selon les besoins spécifiques.

# Systemes et Architectures prises en charge
- Linux : `amd64` , `arm64`

## Prérequis
- **Docker** : Assurez-vous que Docker est installé sur votre système. Vous pouvez télécharger et installer Docker depuis [Docker Hub](https://www.docker.com/get-started).
- **Permissions Docker** : L'utilisateur doit avoir les permissions nécessaires pour exécuter les commandes Docker. Cela peut nécessiter l'ajout de votre utilisateur au groupe `docker` ou l'utilisation de `sudo`.
- **Ressources Système** : Vérifiez que votre système dispose de suffisamment de ressources (CPU, mémoire, stockage) pour exécuter le conteneur de manière efficace.
- **Accès Internet** (si nécessaire) : Selon les fonctionnalités de la configuration NeoVim, un accès Internet pourrait être requis pour télécharger des plugins ou des mises à jour.
- **Configurations Optionnelles** : Si vous prévoyez de monter des volumes pour persister vos configurations ou projets, assurez-vous que les chemins de volumes sont correctement configurés.


## Installation

Pour installer et utiliser cette configuration NeoVim dockerisée, suivez ces étapes :

1. Clonez ce dépôt
```
git clone https://github.com/0x07cb/neovim-ide.git
```
2. [Construisez l'image Docker](DOCKER_BUILD.md)
3. Lancez le conteneur

## Utilisation

Pour utiliser cette configuration NeoVim dockerisée, suivez les étapes ci-dessous :

### 1. Lancer le conteneur Docker

Exécutez la commande suivante pour lancer le conteneur NeoVim. Remplacez `/chemin/vers/votre/projet` par le chemin de votre projet local.

```bash
docker run --rm -it \
    -v /chemin/vers/votre/projet:/workspace \
    -v ~/.config/nvim:/home/dockeruser/.config/nvim \
    neovim-ide:latest
```

**Explications des options :**
- `--rm` : Supprime le conteneur une fois qu'il est arrêté.
- `-it` : Ouvre une session interactive avec un terminal.
- `-v /chemin/vers/votre/projet:/workspace` : Monte votre projet local dans le conteneur pour un accès facile.
- `-v ~/.config/nvim:/home/dockeruser/.config/nvim` : Monte votre configuration NeoVim locale dans le conteneur, vous permettant de personnaliser votre environnement.

### 2. Accéder à NeoVim

Une fois le conteneur lancé, vous serez dans un shell interactif. Pour ouvrir NeoVim, tapez simplement :

```bash
nvim
```

### 3. Personnaliser la Configuration

Votre configuration NeoVim se trouve sur votre machine hôte et est montée dans le conteneur. Vous pouvez la modifier directement en éditant les fichiers dans `~/.config/nvim`. Les modifications seront automatiquement disponibles dans le conteneur.

### 4. Gestion des Plugins

Les plugins sont gérés via LazyVim. Pour installer de nouveaux plugins ou mettre à jour les existants, utilisez les commandes suivantes dans NeoVim :

- **Installer les plugins :**
  ```vim
  :Lazy install
  ```

- **Mettre à jour les plugins :**
  ```vim
  :Lazy update
  ```

### 5. Sauvegarder les Modifications

Assurez-vous que toutes les configurations et les projets sont sauvegardés sur votre machine hôte grâce au montage des volumes. Cela garantit que vos données persistent même après l'arrêt du conteneur.

### 6. Arrêter le Conteneur

Pour arrêter le conteneur, vous pouvez simplement quitter NeoVim et fermer le terminal, ou utiliser la combinaison de touches `Ctrl + D` dans le shell interactif.

### Exemple Complet

Voici un exemple complet de commande pour lancer le conteneur avec un projet spécifique :

```bash
docker run --rm -it \
    -v ~/projets/myapp:/workspace \
    -v ~/.config/nvim:/home/dockeruser/.config/nvim \
    neovim-ide:latest
```

Dans cet exemple :
- Le projet `myapp` situé dans `~/projets` est monté dans le conteneur.
- La configuration NeoVim locale est utilisée à l'intérieur du conteneur.

### Remarques

- **Permissions :** Assurez-vous que votre utilisateur a les permissions nécessaires pour exécuter des commandes Docker sans `sudo`. Sinon, préfixez les commandes Docker avec `sudo`.
- **Mises à Jour :** Pour obtenir les dernières mises à jour de la configuration NeoVim, reconstruisez l'image Docker en suivant les instructions dans la section [Construisez l'image Docker](DOCKER_BUILD.md).

En suivant ces étapes, vous pourrez utiliser efficacement la version dockerisée de NeoVim et profiter d'un environnement de développement cohérent et personnalisable.

## Configuration


## Personnalisation des Plugins

## Contribution

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Auteurs

- **Richard Daniel Sanchez** ([0x07cb](https://github.com/0x07cb))

## Remerciements

