🛡️ CALDERA Installation Guide

📌 Overview

This script automates the installation of MITRE CALDERA on Debian 12.4.0.

✅ Prerequisites

Debian 12.4.0

Sudo privileges

⚡ Installation Steps

1️⃣ Update System

sudo apt-get update && sudo apt-get upgrade -y

2️⃣ Install Essential Packages

sudo apt-get install -y python3 python3-pip python3-venv git openssl libssl-dev curl

3️⃣ Clone the CALDERA Repository

git clone https://github.com/mitre/caldera.git --recursive

4️⃣ Create Virtual Environment & Install Dependencies

cd caldera
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

5️⃣ Install Go

GO_VERSION="1.21.1"
wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
rm go$GO_VERSION.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

6️⃣ Install Node.js & npm

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

7️⃣ Install Docker Module for Python

pip install docker

8️⃣ Install UPX (Manually from GitHub)

wget https://github.com/upx/upx/releases/download/v5.0.0/upx-5.0.0-amd64_linux.tar.xz
tar -xvf upx-5.0.0-amd64_linux.tar.xz
sudo mv upx-5.0.0-amd64_linux/upx /usr/local/bin/
rm -rf upx-5.0.0-amd64_linux upx-5.0.0-amd64_linux.tar.xz

9️⃣ Update VPS IP Address

VPS_IP=$(curl -s ip.me)
sed -i "s|http://[0-9\.]*:8888|http://$VPS_IP:8888|g" conf/default.yml
sed -i "s|http://localhost:8888|http://$VPS_IP:8888|g" conf/default.yml

🔟 Start CALDERA Server

python3 server.py --insecure --build

🎉 Done! Access CALDERA at http://<your_vps_ip>:8888
