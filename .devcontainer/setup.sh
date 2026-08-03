#!/bin/bash
set -e

echo "[+] Updating Kali..."
apt-get update -y

echo "[+] Installing core tools..."
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    kali-linux-headless 2>/dev/null || \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    kali-linux-core

echo "[+] Setting up SSH..."
apt-get install -y openssh-server
mkdir -p /run/sshd
echo 'root:toor' | chpasswd
echo 'kali:kali' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
/usr/sbin/sshd

echo "[+] Done. Kali Linux is ready."
echo "    SSH: ssh root@localhost -p 22  (root/toor)"
echo "    Or use the web terminal."
