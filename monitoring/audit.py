#!/usr/bin/env python3
import subprocess
import json
import csv
from datetime import datetime

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, shell=True, text=True).strip()
    except subprocess.CalledProcessError:
        return "ERROR"

def check_ssh_config():
    sshd = run_cmd("grep -E 'PermitRootLogin|PasswordAuthentication' /etc/ssh/sshd_config")
    return sshd

def check_ufw_status():
    return run_cmd("sudo ufw status verbose")

def check_fail2ban_status():
    status = run_cmd("sudo systemctl is-active fail2ban")
    jail = run_cmd("sudo fail2ban-client status sshd")
    return status, jail

def check_open_ports():
    return run_cmd("ss -tulpen")

def check_services():
    return run_cmd("systemctl list-units --type=service --state=running")

def export_json(data):
    with open("audit_report.json", "w") as f:
        json.dump(data, f, indent=4)

def export_csv(data):
    with open("audit_report.csv", "w", newline="") as f:
        writer = csv.writer(f)
        for key, value in data.items():
            writer.writerow([key, value])

def main():
    print("\n=== AEGIS - Audit de Sécurité ===\n")

    report = {
        "date": str(datetime.now()),
        "ssh_config": check_ssh_config(),
        "ufw_status": check_ufw_status(),
        "fail2ban_status": check_fail2ban_status()[0],
        "fail2ban_jail": check_fail2ban_status()[1],
        "open_ports": check_open_ports(),
        "running_services": check_services()
    }

    for key, value in report.items():
        print(f"\n--- {key.upper()} ---")
        print(value)

    export_json(report)
    export_csv(report)

    print("\n[OK] Rapport généré : audit_report.json & audit_report.csv\n")

if __name__ == "__main__":
    main()
