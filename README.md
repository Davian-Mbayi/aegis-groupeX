# Projet-Cyber (AEGIS)

## Description
Ce projet, nommé **AEGIS**, regroupe un ensemble d'outils et de scripts destinés à la sécurisation (hardening) et à l'audit continu d'un serveur GNU/Linux. Il permet d'automatiser le durcissement des services vitaux et de générer des rapports de sécurité détaillés.

## Auteur
* **Kenneth ADJE** (Groupe X)

## Architecture du projet

Le projet est divisé en deux grandes parties : les scripts d'installation/durcissement et les scripts de monitoring.

* **`/installations/`** : Scripts Bash pour la configuration sécurisée du système.
  * `hardening_ssh.sh` : Script de durcissement SSH. Crée l'utilisateur administrateur `chefsupreme`, l'ajoute au groupe `sudo`, désactive la connexion distante du compte `root` (PermitRootLogin no) et désactive l'authentification par mot de passe (PasswordAuthentication no).
  * `hardening_ufw.sh` : Déploiement et configuration du pare-feu UFW. Bloque tout le trafic entrant par défaut et ouvre uniquement les ports 22 (SSH), 80 (HTTP) et 443 (HTTPS).
  * `hardening_fail2ban.sh` : Installation et configuration de Fail2ban pour protéger le service SSH. Applique un bannissement via UFW après 5 tentatives de connexion échouées.

* **`/monitoring/`** (et `audit.py` à la racine) : Outils pour l'audit de sécurité.
  * `audit.py` : Script Python permettant de tester si tous les outils de sécurité sont bien installés et configurés. Il vérifie la configuration SSH, le statut de UFW, l'état de Fail2ban, les ports ouverts (via `ss -tulpen`) et les services en cours d'exécution.
  * `requirements.txt` : Liste des dépendances Python requises pour l'audit (`python-nmap`, `paramiko`).
  * `audit_report.json` / `audit_report.csv` : Rapports générés automatiquement par l'audit (fichiers ignorés par `.gitignore`).

## Prérequis
* Système d'exploitation : Distribution GNU/Linux (idéalement basée sur Debian/Ubuntu)
* Privilèges d'administrateur (`root` ou utilisateur avec droits `sudo`)
* Python 3 avec `pip`

## Utilisation

### 1. Durcissement du système (Hardening)
Rendez-vous dans le dossier `installations/` et exécutez les scripts un par un avec les droits administrateur pour sécuriser votre serveur :

```bash
cd installations/
sudo ./hardening_ssh.sh
sudo ./hardening_ufw.sh
sudo ./hardening_fail2ban.sh
