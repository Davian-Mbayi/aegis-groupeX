# mise à jour
sudo apt update

# Installation de fail2ban
sudo apt install fail2ban -y

# Configuration de fail2ban
sudo systemctl enable fail2ban

# Démarrage du service fail2ban
sudo systemctl start fail2ban

# Vérification du statut de fail2ban
sudo systemctl status fail2ban

