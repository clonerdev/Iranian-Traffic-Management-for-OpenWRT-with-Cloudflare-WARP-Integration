#!/bin/sh

# Function to retrieve and update the list of Iranian IP addresses
update_iran_ip_list() {
  local github_url="https://raw.githubusercontent.com/arastu/iran_ip_ranges/master/iran_ip_range.txt"
  local temp_file="/tmp/iran_ip_range.txt"

  # Fetching the list of Iranian IP addresses from GitHub
  curl -o $temp_file $github_url

  # Removing all previous records of Iranian IP addresses
  ipset flush Iran_IPs

  # Creating new records for the list of Iranian IP addresses
  while IFS= read -r line; do
    ipset add Iran_IPs $line
  done < $temp_file

  # Removing the temporary file
  rm $temp_file
}

# Execute the function to update the list of Iranian IP addresses
update_iran_ip_list

# Routing settings and other configurations
# Add your routing rules here. For example:

# Direct traffic inside Iran
ip route add 192.168.0.0/16 via 192.168.1.1 comment "Direct traffic inside Iran"

# Cloudflare WARP routing (assuming WARP client is configured and running)
iptables -t mangle -A PREROUTING -m set ! --match-set Iran_IPs dst -j MARK --set-mark 1
ip rule add fwmark 1 table warp
ip route add default dev warp table warp

# Cron job to update the list of Iranian IP addresses every 24 hours
(crontab -l 2>/dev/null; echo "0 0 * * * /path/to/this/script.sh") | crontab -

# Display status in the system log (as OpenWRT doesn't have a system tray menu)
if pgrep warp-svc > /dev/null; then
  logger "Cloudflare WARP (Enabled) v1.0"
else
  logger "Cloudflare WARP (Disabled) v1.0"
fi
