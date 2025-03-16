# 🛡️ **CALDERA Installation Guide **

## ⚡️ **Overview**

A complete installation script to set up the **MITRE CALDERA** adversary emulation platform on **Debian 12.4.0**.

---

## 📌 What is Caldera? 

> Caldera™ is an adversary emulation platform designed to easily run autonomous breach-and-attack simulation exercises. It can also be used to run manual red-team engagements or automated incident response. Caldera is built on the MITRE ATT&CK™ framework and is an active research project at MITRE.

##  🚨 Installation Guide  🚨

> At the time of posting this, the latest version of Caldera is **5.2.0**. To clone the installation script from this repository:

### Please follow the steps below: 

```bash
git clone https://github.com/mattie1/caldera-install.git
```

Navigate to the directory:

```bash
cd caldera-install
```

Set executable permissions to the installation script:

```bash
sudo chmod +x caldera-install.sh
```

Run the installation script:

```bash
./caldera-install.sh
```

---

## ✅ **Prerequisites**

- Debian 12.4.0
- Sudo privileges
- Stable internet connection

## 🛠️ **What this script does**

✅ Installs essential packages
✅ Creates a virtual environment to handle Python dependencies
✅ Installs Go and Node.js
✅ Installs Docker and UPX manually (due to Debian repository issues)
✅ Updates Caldera configuration with your VPS IP
✅ Starts the Caldera server

---

## 🌐 **Access Caldera Web Interface**

```bash
http://<your_vps_ip>:8888
```

---

## 🔄 **Starting & Stopping Caldera Server**

### Start the server:

```bash
python3 server.py --insecure --build
```

### Stop the server:

Press `Ctrl + C` in the terminal window where the server is running.

---

## 🛑 **Troubleshooting**

If you encounter issues with missing dependencies, double-check the logs and ensure you have internet connectivity. For missing packages, manually search for installation commands (Google is your friend!).

---

## 📂 **Directory Structure**

```bash
caldera/
│
├── conf/
├── plugins/
├── server.py
├── venv/
└── caldera.sh
```

---

## 🎯 **Final Thoughts**

This script was tested on **Debian 12.4.0** and aims to automate the entire CALDERA installation process. Enjoy building your adversary emulation environment! 🎭

---

🔥 **Happy Hacking!** 👾

