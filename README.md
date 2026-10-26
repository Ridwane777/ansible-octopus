# Ansible Octopus

Ansible automation that deploys a distributed **voting application** on five Debian 13 machines, from bare VMs to running services, idempotently.

| Host | Role | What it deploys |
|---|---|---|
| `redis-1` | `redis` | Redis server used as the vote queue |
| `postgresql-1` | `postgresql` | PostgreSQL 16 (PGDG repo), `paul` user and database, `votes` schema, restricted `pg_hba.conf` |
| `poll-1` | `poll` | Python voting front-end served by Gunicorn as a systemd service |
| `worker-1` | `worker` | Java 21 worker built with Maven, moving votes from Redis to PostgreSQL |
| `result-1` | `result` | Node.js 20 (NodeSource) results web app as a systemd service |

A `base` role runs on every host: package upgrades, base packages, timezone, SSH.

## Highlights

- **Roles and handlers**: one role per service; restarts go through handlers, only when the configuration changes.
- **Idempotence**: a second run reports no changes (schema import is skipped if the `votes` table exists, apt cache validity, static config files).
- **Secrets with Ansible Vault**: the database password lives in an encrypted `group_vars/all/vault.yml`, never in clear text.
- **Service discovery through the inventory**: systemd units get Redis and PostgreSQL addresses from `hostvars`.
- **Debian 13 fixes**: PGDG `trixie` repository, `acl` for `become_user`, `--break-system-packages` for pip, `get_url` instead of the deprecated `apt-key`.

## Getting started

### 1. Machines
A `Vagrantfile` creates the five VMs on a private network (`192.168.56.101` to `.105`):
```bash
vagrant up
cp inventory.example.ini production
```

### 2. Application archives
The roles expect the application sources as `poll.tar`, `worker.tar` and `result.tar` at the repository root (not versioned).

### 3. Secrets
```bash
cp group_vars/all/vault.yml.example group_vars/all/vault.yml   # set vault_postgres_password
echo 'your-vault-password' > .vault_pass && chmod 600 .vault_pass
ansible-vault encrypt group_vars/all/vault.yml
```

### 4. Deploy
```bash
ansible-playbook -i production playbook.yml
```

## Author

[Ridwane777](https://github.com/Ridwane777)
