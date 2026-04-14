#!/bin/bash

echo "[*] Création utilisateur admin..."
adduser --disabled-password --gecos "" chefsupreme
usermod -aG sudo chefsupreme

echo "[*] Durcissement SSH..."
sed -i 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "[*] Redémarrage SSH..."
systemctl restart ssh

echo "[OK] SSH durci."
