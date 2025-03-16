#!/bin/bash

# CALDERA Installation Script for Debian 12.4.0
#
# Important Notes:
# - This script is specifically tested on Debian 12.4.0.
# - Prior issues with UPX and other libraries are resolved by manually downloading from GitHub.
# - Ensure you have sudo privileges before running the script.
# - Runs within a virtual environment to avoid "externally-managed-environment" error.

# Function to check command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "[❌] Error: $1 failed. Exiting..."
    exit 1
  fi
}

# Function to check if a package is installed
is_installed() {
  dpkg -l | grep -q $1
}

# Step 1: Update and upgrade the system
echo "[🔄] Updating system..."
sudo apt-get update && sudo apt-get upgrade -y
check_success "System update"

# Step 2: Install essential packages
ESSENTIAL_PACKAGES=("python3" "python3-pip" "python3-venv" "git" "openssl" "libssl-dev" "curl")
for package in "${ESSENTIAL_PACKAGES[@]}"; do
  echo "[📦] Installing $package..."
  sudo apt-get install -y $package
  check_success "$package installation"
done

# Step 3: Force Git installation (if not installed)
echo "[🔧] Ensuring Git is installed..."
if ! command -v git &> /dev/null; then
  sudo apt-get install -y git
  check_success "Git installation"
fi

# Step 4: Clone Caldera repository
echo "[🛠️] Cloning CALDERA repository..."
if [ ! -d "caldera" ]; then
  git clone https://github.com/mitre/caldera.git --recursive
  check_success "Cloning CALDERA repository"
else
  echo "[ℹ️] CALDERA repository already exists. Skipping."
fi

# Step 5: Install Python dependencies
cd caldera || exit

# Create a virtual environment to avoid "externally-managed-environment" error
if [ ! -d "venv" ]; then
  echo "[🐍] Creating virtual environment..."
  python3 -m venv venv
  check_success "Virtual environment creation"
fi

source venv/bin/activate

# Install dependencies
echo "[🐍] Installing Python dependencies..."
pip install -r requirements.txt
check_success "Python dependencies installation"

# Step 6: Install Go
echo "[⚙️] Installing Go..."
if ! command -v go &> /dev/null; then
  GO_VERSION="1.21.1"
  wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
  check_success "Downloading Go"
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
  check_success "Go installation"
  rm go$GO_VERSION.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
  source ~/.profile
else
  echo "[✔️] Go is already installed. Skipping."
fi

# Step 7: Install Node.js and npm
echo "[🌐] Installing Node.js and npm..."
if ! command -v node &> /dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  check_success "Node.js setup script"
  sudo apt-get install -y nodejs
  check_success "Node.js and npm installation"
else
  echo "[✔️] Node.js and npm are already installed. Skipping."
fi

# Step 8: Install Docker module for Python
if ! pip show docker &> /dev/null; then
  echo "[🐋] Installing Docker Python module..."
  pip install docker
  check_success "Docker module installation"
else
  echo "[✔️] Docker module is already installed. Skipping."
fi

# Step 9: Install UPX (Optional for packing binaries)
if ! command -v upx &> /dev/null; then
  echo "[🔧] Installing UPX..."
  wget https://github.com/upx/upx/releases/download/v5.0.0/upx-5.0.0-amd64_linux.tar.xz
  check_success "Downloading UPX"
  tar -xvf upx-5.0.0-amd64_linux.tar.xz
  check_success "Extracting UPX"
  sudo mv upx-5.0.0-amd64_linux/upx /usr/local/bin/
  check_success "Installing UPX"
  rm -rf upx-5.0.0-amd64_linux upx-5.0.0-amd64_linux.tar.xz
else
  echo "[✔️] UPX is already installed. Skipping."
fi

# Step 10: Fetch VPS IP and update configuration
VPS_IP=$(curl -s ip.me)
if [ -z "$VPS_IP" ]; then
  echo "[❌] Error: Unable to retrieve VPS IP address."
  exit 1
fi

# Update caldera/conf/default.yml
if [ -f "conf/default.yml" ]; then
  sed -i "s|http://[0-9\.]*:8888|http://$VPS_IP:8888|g" conf/default.yml
  sed -i "s|http://localhost:8888|http://$VPS_IP:8888|g" conf/default.yml
  echo "[🔧] Updated IP in conf/default.yml"
fi

# Update caldera/plugins/magma/.env
if [ -f "plugins/magma/.env" ]; then
  sed -i "s|VITE_CALDERA_URL=http://[0-9\.]*:8888|VITE_CALDERA_URL=http://$VPS_IP:8888|g" plugins/magma/.env
  sed -i "s|VITE_CALDERA_URL=http://localhost:8888|VITE_CALDERA_URL=http://$VPS_IP:8888|g" plugins/magma/.env
  echo "[🔧] Updated IP in plugins/magma/.env"
fi

# Step 11: Start CALDERA Server
echo "[🚀] Starting CALDERA server..."
python3 server.py --insecure --build
check_success "CALDERA server startup"

echo "✅ CALDERA installation and configuration complete!"
