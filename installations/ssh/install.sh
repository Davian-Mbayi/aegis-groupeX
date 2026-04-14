#!/bin/bash
# Installation et durcissement de SSH

sudo apt update
sudo apt install -y openssh-server

# 1. Changer le port par défaut
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# 2. Désactiver la connexion en root
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 3. Forcer l'authentification par clé
# Attention : Assurez-vous d'avoir copié votre clé avant de passer PasswordAuthentication à 'no'
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Redémarrage du service pour appliquer les changements
sudo systemctl restart ssh
