#!/bin/bash

# <UDF name="USERNAME" label="Username" />
# <UDF name="PASSWORD" label="Password" />
# <UDF name="SSH_KEY" label="Public SSH Key" />
# <UDF name="SSH_PORT" label="SSH Port" default="22" />
# <UDF name="PERMIT_ROOT_LOGIN" label="Allow SSH root login" oneOf="Yes,No" default="No" />
# <UDF name="PASSWORD_AUTH" label="Allow password authentication" oneOf="Yes,No" default="No" />

# Creating the user
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Adding the user to the sudo group
usermod -aG sudo "$USERNAME"

# Creating the .ssh directory for the user
mkdir -p /home/"$USERNAME"/.ssh
chmod 700 /home/"$USERNAME"/.ssh

# Adding the public SSH key to the authorized_keys file
echo "$SSH_KEY" > /home/"$USERNAME"/.ssh/authorized_keys
chmod 600 /home/"$USERNAME"/.ssh/authorized_keys
chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh

# Setting permissions for the user's home directory
chmod 750 /home/"$USERNAME"

echo "L'utilisateur $USERNAME a été créé avec succès."


# SSH server configuration
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

# Restarting the SSH service to apply changes
systemctl restart sshd

# ##########################################################
# Script to configure an SSH server with specific settings on Debian 12
#
# Updating system packages
apt-get update
apt-get upgrade -y

# Installing required packages
apt-get install -y \
    apt-transport-https \
    gnupg \
    lsb-release \
    software-properties-common

#
# #############################
# Adding Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
#
# Adding the repository to Apt sources:
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
# Adding the user to the docker group
usermod -aG docker $USERNAME
# ##########################################################





