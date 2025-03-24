#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -i <interface> [-r | -m <mac_address>]"
    echo "  -i: Network interface (e.g., wlan0, eth0)"
    echo "  -r: Generate random MAC address"
    echo "  -m: Specify custom MAC address (format: XX:XX:XX:XX:XX:XX)"
    exit 1
}

# Function to validate MAC address format
validate_mac() {
    if [[ ! $1 =~ ^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$ ]]; then
        echo "Invalid MAC address format. Use XX:XX:XX:XX:XX:XX"
        exit 1
    fi
}

# Function to generate random MAC address
random_mac() {
    printf '%02x:%02x:%02x:%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
}

# Check if parameters are provided
if [ $# -eq 0 ]; then
    usage
fi

# Parse command line arguments
while getopts "i:rm:" opt; do
    case $opt in
        i) INTERFACE="$OPTARG";;
        r) RANDOM_MAC=1;;
        m) CUSTOM_MAC="$OPTARG";;
        ?) usage;;
    esac
done

# Check if interface is specified
if [ -z "$INTERFACE" ]; then
    echo "Error: Network interface must be specified"
    usage
fi

# Verify interface exists
if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
    echo "Error: Interface $INTERFACE does not exist"
    exit 1
fi

# Check if both random and custom MAC are specified
if [ ! -z "$RANDOM_MAC" ] && [ ! -z "$CUSTOM_MAC" ]; then
    echo "Error: Cannot use both random (-r) and custom (-m) MAC address options"
    usage
fi

# Get current MAC address
CURRENT_MAC=$(ip link show "$INTERFACE" | awk '/ether/ {print $2}')
echo "Current MAC address: $CURRENT_MAC"

# Determine new MAC address
if [ ! -z "$CUSTOM_MAC" ]; then
    validate_mac "$CUSTOM_MAC"
    NEW_MAC="$CUSTOM_MAC"
elif [ ! -z "$RANDOM_MAC" ]; then
    NEW_MAC=$(random_mac)
else
    echo "Error: Please specify either random (-r) or custom (-m) MAC address"
    usage
fi

echo "New MAC address will be: $NEW_MAC"

# Change MAC address
echo "Changing MAC address..."
ip link set "$INTERFACE" down || { echo "Failed to bring interface down"; exit 1; }
ip link set "$INTERFACE" address "$NEW_MAC" || { echo "Failed to set new MAC"; exit 1; }
ip link set "$INTERFACE" up || { echo "Failed to bring interface up"; exit 1; }

echo "MAC address successfully changed!"
echo "Verifying new MAC address..."
sleep 2
NEW_CURRENT_MAC=$(ip link show "$INTERFACE" | awk '/ether/ {print $2}')
echo "Current MAC address is now: $NEW_CURRENT_MAC"