# Overview:
This project is designed to manage internet traffic on OpenWRT routers by routing non-Iranian IP traffic through Cloudflare WARP and directly routing Iranian IP traffic. The script also updates the list of Iranian IP addresses every 24 hours to ensure the configuration remains up-to-date.

# Objectives:
1. Route non-Iranian traffic through Cloudflare WARP.
2. Direct Iranian traffic without routing through Cloudflare WARP.
3. Automatically update the list of Iranian IP addresses every 24 hours.

# Prerequisites:
- OpenWRT installed on your router.
- Basic knowledge of using the command line interface (CLI) on OpenWRT.
- Ensure your router has internet access to fetch the latest IP list and communicate with Cloudflare WARP.

# Instructions:

1. **Copy the Code**:
   - Copy the script and save it as `config.sh`.

2. **Upload and Execute the Script**:
   - Upload the `config.sh` script to your OpenWRT router.
   - Make the script executable: `chmod +x /path/to/config.sh`
   - Execute the script: `sh /path/to/config.sh`

3. **Create a Backup**:
   - Before making changes, it's recommended to create a backup of your current configuration. This can be done via the OpenWRT web interface or CLI using the following command:
   ```sh
   sysupgrade -b /tmp/backup.tar.gz
   ```

4. **Review Output**:
   - After running the script, check the system log to ensure everything is set up correctly:
   ```sh
   logread | grep "Cloudflare WARP"
   ```

5. **Verify Cron Job**:
   - Ensure that the cron job is added correctly by checking the crontab entries:
   ```sh
   crontab -l
   ```

# Requirements:
- **OpenWRT**: This script is intended for use with OpenWRT devices.
- **Internet Connection**: The device must have an internet connection to update the list of Iranian IP addresses and communicate with Cloudflare WARP.

# Minimum Version:
- This script is compatible with various versions of OpenWRT. However, for optimal performance and compatibility, it is recommended to use the latest stable release.

# Notes:
- **Automatic Updates**: The script includes a cron job that updates the list of Iranian IP addresses every 24 hours.
- **Routing Rules**: The script sets up routing rules to direct traffic appropriately based on the IP address lists.

# License:
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

# Conclusion:
By following this guide, you can configure your OpenWRT router to manage Iranian and non-Iranian traffic effectively, leveraging Cloudflare WARP for enhanced security and privacy. The automatic updating of IP addresses ensures that your configuration remains current without manual intervention.
