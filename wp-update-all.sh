#!/bin/bash

# User Settings
WWW="/var/www"
LOG_DIR="/var/log"
TIMEZONE="America/Denver"

# Script Settings
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
WP="$DIR/wp"
LOG_FILE="$LOG_DIR/wp-updater.log"
LOG_ERROR_FILE="$LOG_DIR/wp-updater-error.log"
TIMESTAMP="$(TZ="$TIMEZONE" date "+%Y-%m-%d%l:%M:%S %p")"
GREEN="\e[32m"
WHITE="\e[37m"
BOLD="\e[1m"
N="\e[m" # Normal

echo -e "$BOLD$GREEN"
echo "__          _______    _    _           _       _            "
echo "\ \        / /  __ \  | |  | |         | |     | |           "
echo " \ \  /\  / /| |__) | | |  | |_ __   __| | __ _| |_ ___ _ __ "
echo "  \ \/  \/ / |  ___/  | |  | | '_ \ / _\` |/ _\` | __/ _ \ '__|"
echo "   \  /\  /  | |      | |__| | |_) | (_| | (_| | ||  __/ |   "
echo "    \/  \/   |_|       \____/| .__/ \__,_|\__,_|\__\___|_|   "
echo "                             | |                             "
echo "                             |_|                             "
echo -e "$N"

echo -e "#########################" | tee -a "$LOG_FILE" -a "$LOG_ERROR_FILE"
echo -e "# $TIMESTAMP #" | tee -a "$LOG_FILE" -a "$LOG_ERROR_FILE"
echo -e "#########################\n" | tee -a "$LOG_FILE" -a "$LOG_ERROR_FILE"

# Check for updates to the WP-CLI
$WP --allow-root cli update 1>>$LOG_FILE 2>>$LOG_ERROR_FILE

for DIRECTORY in $(find "$WWW" -name 'wp-config.php' | xargs dirname); do
    cd "$DIRECTORY"
    SITENAME=$(basename "$DIRECTORY")
    echo -e "\n------------------\n\nUpgrading $SITENAME...\n" | tee -a "$LOG_FILE" -a "$LOG_ERROR_FILE"

    # Upgrade WordPress install
    $WP --allow-root core update 1>>$LOG_FILE 2>>$LOG_ERROR_FILE
    $WP --allow-root core update-db 1>>$LOG_FILE 2>>$LOG_ERROR_FILE

    # Upgrade Plugins
    $WP --allow-root plugin update --all 1>>$LOG_FILE 2>>$LOG_ERROR_FILE

    # Upgrade Themes
    $WP --allow-root theme update --all 1>>$LOG_FILE 2>>$LOG_ERROR_FILE
done

echo -e "\n" | tee -a "$LOG_FILE" -a "$LOG_ERROR_FILE"
echo -e "Check the log files for details.\n$LOG_FILE\n$LOG_ERROR_FILE\n"

