
[![DockerHub](https://img.shields.io/badge/DockerHub-0x07cb%2Fneovim--ide-blue)](https://hub.docker.com/r/0x07cb/neovim-ide)

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

Bienvenue dans **neovim-ide** – une configuration NeoVim dockerisée innovante basée sur le plugin LazyVim. Que vous soyez un développeur chevronné ou débutant, notre configuration vous offre un environnement de développement puissant, flexible et facile à personnaliser. Profitez d'une productivité accrue grâce à des outils intégrés, une gestion efficace des plugins, et une interface épurée qui s'adapte à vos besoins. Plongez dans une expérience de codage optimisée et découvrez la puissance de NeoVim comme jamais auparavant !

## Fonctionnalités

- **Multi-plateforme** : L'image est conçue pour fonctionner sur les plateformes `linux/arm64` et `linux/amd64`.
- **Docker** : L'image est basée sur Docker, ce qui permet une installation et une utilisation faciles.
- **LazyVim** : Utilisation du plugin LazyVim pour une configuration NeoVim optimisée.
- **Plugins** : Intégration de plugins essentiels pour une productivité maximale.
- **Personnalisation** : Facilité de personnaliser la configuration selon les besoins spécifiques.

## Systèmes et architectures pris en charge

- Linux : `amd64`, `arm64`

## Prérequis

- **Docker** : Assurez-vous que Docker est installé sur votre système. Vous pouvez télécharger et installer Docker depuis [Docker Hub](https://www.docker.com/get-started).
- **Permissions Docker** : L'utilisateur doit avoir les permissions nécessaires pour exécuter les commandes Docker. Cela peut nécessiter l'ajout de votre utilisateur au groupe `docker` ou l'utilisation de `sudo`.
- **Ressources système** : Vérifiez que votre système dispose de suffisamment de ressources (CPU, mémoire, stockage) pour exécuter le conteneur de manière efficace.
- **Accès Internet** (si nécessaire) : Selon les fonctionnalités de la configuration NeoVim, un accès Internet pourrait être requis pour télécharger des plugins ou des mises à jour.
- **Configurations optionnelles** : Si vous prévoyez de monter des volumes pour persister vos configurations ou projets, assurez-vous que les chemins de volumes sont correctement configurés.

## Installation

Pour installer et utiliser cette configuration NeoVim dockerisée, suivez ces étapes :

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/0x07cb/neovim-ide.git
   ```

2. [Construire l'image Docker](DOCKER_BUILD.fr.md)

3. Lancez le conteneur.

## Utilisation

Pour utiliser cette configuration NeoVim dockerisée comme vous utiliseriez la commande `nvim` classique, suivez ces étapes :

### 1. Lancer le conteneur Docker

Utilisez la commande suivante pour lancer le conteneur NeoVim, en montant le répertoire courant dans le conteneur :

```bash
docker run --rm -it \
    -v $(pwd):/home/appuser/data \
    neovim-ide:latest \
    nvim "$@"
```

**Explication des options** :
- `--rm` : Supprime le conteneur une fois qu'il est arrêté.
- `-it` : Ouvre une session interactive avec un terminal.
- `-v $(pwd):/home/appuser/data` : Monte le répertoire courant dans le dossier `/home/appuser/data` du conteneur.
- `"$@"` : Passe tous les arguments de ligne de commande à la commande `nvim` dans le conteneur.

### 2. Créer un alias

Pour simplifier l'utilisation, vous pouvez créer un alias dans votre fichier de configuration shell (`.bashrc` ou `.zshrc`). Ajoutez la ligne suivante à votre fichier de configuration :

```bash
alias nvim-docker='docker run --rm -it -v $(pwd):/home/appuser/data neovim-ide:latest nvim'
```

Après avoir ajouté cet alias, rechargez votre configuration shell ou redémarrez votre terminal.

### 3. Utilisation de l'alias

Vous pouvez maintenant utiliser `nvim-docker` comme vous utiliseriez `nvim` normalement. Par exemple :

```bash
# Ouvrir un fichier
nvim-docker fichier.txt

# Ouvrir plusieurs fichiers
nvim-docker fichier1.txt fichier2.txt

# Ouvrir un répertoire
nvim-docker .
```

Le répertoire courant sera automatiquement monté dans le conteneur, vous permettant d'accéder à tous les fichiers du répertoire actuel et de ses sous-répertoires.

### Exemple d'utilisation

Voici quelques exemples d'utilisation :

1. Ouvrir un fichier dans le répertoire courant :
   ```bash
   nvim-docker mon_fichier.py
   ```

2. Ouvrir plusieurs fichiers :
   ```bash
   nvim-docker fichier1.js fichier2.js fichier3.js
   ```

3. Ouvrir un répertoire pour navigation :
   ```bash
   nvim-docker .
   ```

4. Utiliser des options de NeoVim :
   ```bash
   nvim-docker -p fichier1.txt fichier2.txt
   ```
   
### Remarques

- Assurez-vous d'avoir les permissions nécessaires pour exécuter Docker sans `sudo`. Sinon, vous devrez ajuster l'alias en conséquence.
- La première exécution peut prendre un peu de temps car Docker doit télécharger l'image. Les lancements suivants seront plus rapides.
- Toutes les modifications apportées aux fichiers dans NeoVim seront reflétées dans votre système de fichiers local, car le répertoire courant est monté dans le conteneur.

En suivant ces étapes, vous pourrez utiliser efficacement la version dockerisée de NeoVim et profiter d'un environnement de développement cohérent et personnalisable.

## Contribution

Nous accueillons chaleureusement les contributions à ce projet ! Voici comment vous pouvez participer :

1. **Forkez le dépôt** : Créez votre propre copie du projet sur GitHub.
2. **Créez une branche** : `git checkout -b nom-de-votre-fonctionnalite`
3. **Committez vos changements** : `git commit -am 'Ajout d'une nouvelle fonctionnalité'`
4. **Poussez vers la branche** : `git push origin nom-de-votre-fonctionnalite`
5. **Ouvrez une Pull Request** : Soumettez vos modifications pour révision.

### Lignes directrices pour la contribution

- Assurez-vous que votre code respecte les conventions de style du projet.
- Testez soigneusement vos modifications avant de soumettre une pull request.
- Documentez clairement toute nouvelle fonctionnalité ou modification importante.
- Respectez le code de conduite du projet dans toutes vos interactions.

Nous apprécions grandement votre aide pour améliorer ce projet !

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Auteurs

- **Richard Daniel Sanchez** ([0x07cb](https://github.com/0x07cb))

## Remerciements

Nous tenons à remercier chaleureusement :

- La communauté NeoVim pour leur travail exceptionnel sur cet éditeur puissant.
- Les contributeurs du projet LazyVim pour leur configuration inspirante.
- Les développeurs de Docker pour avoir facilité la création d'environnements cohérents.
- Tous les contributeurs open source dont les outils et plugins enrichissent notre expérience de développement.
- Les utilisateurs et testeurs de ce projet pour leurs retours précieux et leur soutien continu.

Votre engagement et votre passion pour l'amélioration des outils de développement sont une source d'inspiration constante pour ce projet.
