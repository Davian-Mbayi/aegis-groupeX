# Outils d'Audit et de Monitoring (AEGIS)

## Description

Ce répertoire contient les scripts et ressources nécessaires pour automatiser l'audit de sécurité du système. L'objectif principal est de vérifier que toutes les mesures de durcissement (UFW, SSH, Fail2ban) sont correctement installées, configurées et actives.

## Contenu du répertoire

* **`audit.py`** : Le script principal d'audit écrit en Python.
* **`requirements.txt`** : Le fichier listant les dépendances Python nécessaires au fonctionnement des scripts (ex: `python-nmap`, `paramiko`).
* **`audit_report.json`** / **`audit_report.csv`** : Fichiers générés automatiquement par le script contenant l'état des lieux du serveur. (Ces fichiers sont ignorés par le suivi Git via `.gitignore`).

## Fonctionnalités couvertes par `audit.py`

Le script effectue des vérifications locales en exécutant des commandes système et collecte les informations suivantes :
1. **Configuration SSH** : Vérifie les valeurs de `PermitRootLogin` et `PasswordAuthentication` dans `/etc/ssh/sshd_config`.
2. **Statut UFW** : Récupère l'état actif/inactif et les règles de pare-feu en place (`ufw status verbose`).
3. **Statut Fail2ban** : Vérifie l'exécution du service et l'état spécifique de la prison (jail) `sshd` (`fail2ban-client status sshd`).
4. **Ports ouverts** : Liste les ports en écoute sur la machine (`ss -tulpen`).
5. **Services en cours d'exécution** : Liste les unités systemd actives.

## Prérequis et Installation

Assurez-vous de disposer de Python 3 et de `pip`. Installez les dépendances avant la première exécution :

```bash
pip install -r requirements.txt
