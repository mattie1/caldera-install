# 🛡️ **CALDERA Installation Guide (Debian 12.4.0)**

## ⚡️ **Overview**
A complete installation script to set up the **MITRE CALDERA** adversary emulation platform on **Debian 12.4.0**.  

Please note that you can install this on any distro, but I have found the above version to work after multiple failures. 

---

## 📌 🚨 **IMPORTANT** 🚨

> At the time of posting this, the latest version of Caldera is **5.2.0**, so please feel free to use the relevant branch name:

```bash
git clone https://github.com/mitre/caldera.git --recursive --branch 5.2.0
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

## 🛑 **Troubleshooting**
If you encounter issues with missing dependencies, check the package that's failed to install, try to manually install it and then re run the script.

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

