#!/bin/bash
# AEGIS - Script de durcissement SSH
# Auteur : Kenneth ADJE
# Date : $(date)

echo "[*] Création de l'utilisateur admin chefsupreme..."
if ! id "chefsupreme" &>/dev/null; then
    adduser --disabled-password --gecos "" chefsupreme
    usermod -aG sudo chefsupreme
    echo "[OK] Utilisateur chefsupreme créé et ajouté au groupe sudo."
else
    echo "[INFO] Utilisateur chefsupreme existe déjà."
fi

echo "[*] Durcissement du fichier sshd_config..."
sed -i 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "[*] Redémarrage du service SSH..."
systemctl restart ssh

echo "[OK] SSH durci avec succès."
echo "     - PermitRootLogin : no"
echo "     - PasswordAuthentication : no"
