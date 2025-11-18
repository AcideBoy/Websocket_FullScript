#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  gum style --foreground "#ff5555" --border double --margin "1 2" --padding "1 2" "🚫 Please run this script as root."
  exit 1
fi

os_name=$(hostnamectl | grep 'Operating System' | cut -d ':' -f2- | xargs)
uptime=$(uptime -p | cut -d " " -f 2-10)
public_ip=$(curl -s ifconfig.me)
vps_domain=$(cat /etc/Acide/domain 2>/dev/null || echo "Not Set")
used_ram=$(free -m | awk 'NR==2 {print $3}')
total_ram=$(free -m | awk 'NR==2 {print $2}')

clear

gum format --theme dracula <<EOF

# 🚀 Acide - VPS Manager

- **OS**         : $os_name  
- **Uptime**     : $uptime  
- **Public IP**  : $public_ip  
- **Domain**     : $vps_domain  

# 🧠 RAM Information

- **Used RAM**   : ${used_ram} MB  
- **Total RAM**  : ${total_ram} MB  

# 📋 Main Menu
EOF

opt=$(gum choose --limit=1 --header "  Choose" \
  "1. Create Account" \
  "2. Delete Account" \
  "3. Renew Account" \
  "4. Lock/Unlock Account" \
  "5. Edit Banner" \
  "6. Change Domain" \
  "7. System Info" \
  "x. Exit" \
  "12. Uninstall" \
  "xx. Exit")

clear
case "$opt" in
  "1. Create Account") create-account ;;
  "2. Delete Account") delete-account ;;
  "3. Renew Account") renew-account ;;
  "4. Lock/Unlock Account") lock-unlock ;;
  "5. Edit Banner") edit-banner ;;
  "6. Change Domain") change-domain ;;
  "7. System Info") system-info ;;
  "x. Exit") exit ;;
  "9. Uninstall") 
    gum confirm "Are you sure you want to uninstall Acide? This action cannot be undone." && bash /etc/Acide/uninstall.sh ;;
  "xx. Exit") exit ;;
esac
