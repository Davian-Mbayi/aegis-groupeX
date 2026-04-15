#!/bin/bashecho "[*] Création utilisateur admin..."adduser --disabled-password --gecos "" chefsupremeusermod -aG sudo chefsupreme
echo "[*] Durcissement SSH..."sed -i 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_configsed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "[*] Redémarrage SSH..."systemctl restart ssh
echo "[OK] SSH durci."