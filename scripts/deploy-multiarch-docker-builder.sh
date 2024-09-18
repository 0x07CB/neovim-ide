#!/bin/bash
#
# ##########################################################
# Script to setup an SSH Server with specific configurations on Debian 12
#
# Update system packages
# Mise à jour complète du système
apt-get update
apt-get upgrade -y

# Installation des paquets requis
apt-get install -y \
    apt-transport-https \
    gnupg \
    lsb-release \
    software-properties-common

#
# #############################
# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
#
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get updatep
#
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
# ##########################################################
systemctl enable docker --now
# ##########################################################
# Add user to docker group
usermod -aG docker $USER
# ##########################################################
