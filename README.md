# 🛡️ **CALDERA Installation Guide (Debian 12.4.0)**

## ⚡️ **Overview**

A complete installation script to set up the **MITRE CALDERA** adversary emulation platform on **Debian 12.4.0**.

---

## 📌 🚨 **IMPORTANT** 🚨

> At the time of posting this, the latest version of Caldera is **5.2.0**. To clone the installation script from this repository:

```bash
git clone https://github.com/mattie1/caldera-install/caldera-install.sh
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

## 🚀 **Installation Steps**

```bash
./caldera.sh
```

---

## 🎯 **Key Fixes & Improvements**

- 🛑 Resolved **"externally-managed-environment"** error with a virtual environment.
- 🛠️ Manually installed UPX from GitHub due to Debian package unavailability.
- ⚡ Automated Go and Node.js installation.

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

If you encounter issues with missing dependencies, double-check the logs and ensure you have internet connectivity.

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

