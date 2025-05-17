# Tapify SSH Bootstrap

This repository contains a single script that bootstraps the SSH configuration needed to clone and deploy Tapify's private repositories.

---

## 🔧 What It Does

This script automates the creation and configuration of SSH keys for three Tapify GitHub repositories:

- `tapify-station-deployment`
- `tapify-station`
- `tapify-tap-ui`

It performs the following steps:

1. Generates **three ed25519 SSH key pairs** in `~/.ssh/`
2. Adds corresponding `Host` entries to your `~/.ssh/config`
3. Displays public keys for you to copy into GitHub Deploy Keys
4. Provides a sample `git clone` command using the configured aliases

---

## 📂 Files

- `bootstrap-ssh.sh` – the main setup script

---

## 🚀 Usage

1. Make the script executable:

```bash
chmod +x bootstrap-ssh.sh
```

2. Run the script:

```bash
./bootstrap-ssh.sh
```

3. After it runs, you’ll see output like:

```
🔗 For repo: tapify-deployment
----------------------------------------
ssh-ed25519 AAAAC3... user@host
----------------------------------------

🧠 Add each key above to its corresponding GitHub repo before cloning.
```

---

## 🧠 GitHub Setup

For each key:

1. Go to the corresponding **GitHub repository**
2. Navigate to **Settings → Deploy keys → Add deploy key**
3. Give it a name like `Auto SSH Key` and paste the public key shown in the terminal

| Repository                 | SSH Host Alias   | SSH Key File                         |
|----------------------------|------------------|--------------------------------------|
| tapify-station-deployment | `github-deploy`  | `~/.ssh/tapify-deploy-deploy`        |
| tapify-station            | `github-station` | `~/.ssh/tapify-deploy-station`       |
| tapify-tap-ui             | `github-tap-ui`  | `~/.ssh/tapify-deploy-tap-ui`        |

> ⚠️ GitHub does **not** allow reusing the same key across multiple repositories.

---

## ✅ Example Clone Command

Once keys are configured and deploy keys are added in GitHub:

```bash
git clone git@github-deploy:Tapify-Romania/tapify-station-deployment.git
```

---

## 🛡 Notes

- The script **does not overwrite** existing keys — it will skip any keys that already exist.
- If `~/.ssh/config` already contains an alias, it won’t duplicate it.
- Keys are generated using `ed25519` for security and performance.

---

## 👥 For Tapify Developers

This script should be run **once per machine** to set up secure Git access to all Tapify repositories.
