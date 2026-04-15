#!/bin/bash
# AEGIS - Script de configuration UFW
# Auteur : Kenneth ADJE

echo "[*] Installation et configuration du pare-feu UFW..."
apt install -y ufw

ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo "[OK] UFW configuré."
ufw status verbose
