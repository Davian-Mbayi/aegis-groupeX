#!/bin/bash
# AEGIS - Script installation Fail2ban
# Auteur : Kenneth ADJE

echo "[*] Installation de Fail2ban..."
apt install -y fail2ban

echo "[*] Configuration de Fail2ban..."
cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
ignoreip = 127.0.0.1/8
bantime  = 10m
findtime = 10m
maxretry = 5
backend  = systemd
banaction = ufw

[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/auth.log
maxretry = 5
EOF

echo "[*] Activation et démarrage..."
systemctl enable --now fail2ban

echo "[OK] Fail2ban actif."
systemctl status fail2ban | grep Active
