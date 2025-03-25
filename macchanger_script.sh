#!/bin/bash

# Interface to change
INTERFACE="eth0" # Default interface, user can change it

# Function to generate a random MAC address
generate_random_mac() {
  local octet
  for i in {1..6}; do
    octet=$(printf "%02x" $((RANDOM % 256)))
    if [[ $i -eq 1 ]]; then
      # Ensure locally administered address (LAA) and unicast
      octet=$(printf "%02x" $(( (RANDOM % 254) | 0x02 )))
    fi
    printf "$octet"
    if [[ $i -lt 6 ]]; then
      printf ":"
    fi
  done
  echo ""
}

# Function to change MAC address
change_mac() {
  local mac_address="$1"
  local permanent="$2"

  ifconfig "$INTERFACE" down
  if [[ -n "$mac_address" ]]; then
    macchanger -m "$mac_address" "$INTERFACE"
  else
    macchanger -r "$INTERFACE"
  fi
  ifconfig "$INTERFACE" up

  if [[ "$permanent" == "y" ]]; then
    # Persist the MAC address (requires systemd or similar)
    if [[ -f /etc/systemd/network/10-macchanger.link ]]; then
        echo "[Match]" > /etc/systemd/network/10-macchanger.link
        echo "MACAddress=$DEFAULT_MAC" >> /etc/systemd/network/10-macchanger.link
        echo "[Link]" >> /etc/systemd/network/10-macchanger.link
        echo "MACAddress=$mac_address" >> /etc/systemd/network/10-macchanger.link
        systemctl restart systemd-networkd
    else
        echo "Warning: Persistent MAC address change requires systemd-networkd configuration."
        echo "Create /etc/systemd/network/10-macchanger.link manually if needed."
    fi
  fi
}

# Get the current MAC address
DEFAULT_MAC=$(macchanger -s "$INTERFACE" | grep "Current MAC" | awk '{print $3}')

# Main script logic
echo "Current Interface: $INTERFACE"
echo "Current MAC: $DEFAULT_MAC"

read -p "Enter 'r' for random MAC, 'm' for manual MAC, 'p' for permanent reset(default), or 'd' for permanent default: " choice

case "$choice" in
  r)
    new_mac=$(generate_random_mac)
    echo "Generated Random MAC: $new_mac"
    read -p "Make this permanent? (y/n): " permanent
    change_mac "$new_mac" "$permanent"
    ;;
  m)
    read -p "Enter new MAC address (e.g., 00:11:22:33:44:55): " new_mac
    if [[ -z "$new_mac" ]]; then
      echo "Invalid MAC address."
      exit 1
    fi
    read -p "Make this permanent? (y/n): " permanent
    change_mac "$new_mac" "$permanent"
    ;;
  p|"") # default
    change_mac "$DEFAULT_MAC" "y" #reset to default mac, and make it permanent
    ;;
  d)
    if [[ -f /etc/systemd/network/10-macchanger.link ]]; then
      rm /etc/systemd/network/10-macchanger.link
      systemctl restart systemd-networkd
      echo "MAC address reset to default permanently."
    else
      echo "Permanent default MAC address already set or no previous permanent change was made."
    fi
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac

echo "MAC address change complete."