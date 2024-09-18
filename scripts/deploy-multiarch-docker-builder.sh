#!/bin/bash

# <UDF name="USERNAME" label="Nom d'utilisateur" />
# <UDF name="PASSWORD" label="Mot de passe" />
# <UDF name="SSH_KEY" label="Clé SSH publique" />
# <UDF name="SSH_PORT" label="Port SSH" default="22" />
# <UDF name="PERMIT_ROOT_LOGIN" label="Autoriser la connexion root SSH" oneOf="Yes,No" default="No" />
# <UDF name="PASSWORD_AUTH" label="Autoriser l'authentification par mot de passe" oneOf="Yes,No" default="No" />

# ... (le code pour la création de l'utilisateur reste inchangé)

# Configuration du serveur SSH
cat << EOF > /etc/ssh/sshd_config
# Configuration SSH sécurisée
Protocol 2
Port $SSH_PORT
PermitRootLogin $([[ "$PERMIT_ROOT_LOGIN" == "Yes" ]] && echo "yes" || echo "no")
PubkeyAuthentication yes
PasswordAuthentication $([[ "$PASSWORD_AUTH" == "Yes" ]] && echo "yes" || echo "no")
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
AllowUsers $USERNAME

# Paramètres de sécurité supplémentaires
MaxAuthTries 3
LoginGraceTime 60
PermitEmptyPasswords no
ClientAliveInterval 300
ClientAliveCountMax 2
EOF

# Redémarrage du service SSH pour appliquer les changements
systemctl restart sshd

# ##########################################################
# Script to setup an SSH Server with specific configurations on Debian 12
#
# Update system packages
# Mise à jour des paquets système
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
apt-get update
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
usermod -aG docker $USERNAME
# ##########################################################





