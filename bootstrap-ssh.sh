#!/bin/bash
set -e

echo "🔐 Bootstrap SSH keys for Tapify deploy, station, and tap-ui repos..."

KEYS=(
  "tapify-deploy-deploy github-deploy"
  "tapify-deploy-station github-station"
  "tapify-deploy-tap-ui github-tap-ui"
)

mkdir -p ~/.ssh
chmod 700 ~/.ssh

for pair in "${KEYS[@]}"; do
  name=$(echo "$pair" | awk '{print $1}')
  hostalias=$(echo "$pair" | awk '{print $2}')
  keypath="$HOME/.ssh/$name"

  if [ -f "$keypath" ]; then
    echo "⚠️  SSH key $keypath already exists. Skipping."
  else
    ssh-keygen -t ed25519 -f "$keypath" -N "" -C "$name"
    echo "✅ Created $keypath"
  fi

  # Add SSH config entry
  if ! grep -q "$hostalias" ~/.ssh/config 2>/dev/null; then
    {
      echo ""
      echo "Host $hostalias"
      echo "  HostName github.com"
      echo "  User git"
      echo "  IdentityFile $keypath"
      echo "  IdentitiesOnly yes"
    } >> ~/.ssh/config
    echo "✅ Added $hostalias to ~/.ssh/config"
  else
    echo "⚠️  Host $hostalias already in ~/.ssh/config"
  fi
done

chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub

echo ""
echo "📎 Public keys to add to GitHub Deploy Keys:"
for pair in "${KEYS[@]}"; do
  name=$(echo "$pair" | awk '{print $1}')
  repo=$(echo "$name" | sed 's/tapify-deploy-//')
  echo ""
  echo "🔗 For repo: tapify-${repo}"
  echo "----------------------------------------"
  cat "$HOME/.ssh/$name.pub"
  echo "----------------------------------------"
done

echo ""
echo "🧠 Add each key above to its corresponding GitHub repo before cloning."
echo "Example:"
echo "git clone git@github-deploy:Tapify-Romania/tapify-station-deployment.git"
