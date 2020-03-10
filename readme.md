# WordPress Updater

WordPress command-line-based nightly updater for bash.


## Description

WordPress Updater is a simple script to update all the WordPress sites installed on the server. It is able to dynamically discover them and update them in four ways:

1. Upgrade WordPress software itself
2. Upgrade the WordPress database version
3. Upgrade any installed Plugins
4. Upgrade any installed Themes

Doing this every night will help keep your server secure from WordPress exploits which are regularly needing to be updated.


## Installation

Just clone or unzip these scripts somewhere on your server and set up a cron job to call them each night.

> WARNING: Do not run this as root!

Use the apache/httpd user instead by running (assuming your apache/httpd user is "www-data"):

`crontab -e -u www-data`

Example crontab entry:

`0 0 * * * /path/to/wp-update-all.sh 2>&1 >/dev/null`

> Note: You don't have to throw away crontab logs, but once you know the script is working, all relevant logs are stored by the script so they are safe to discard.

Make sure that the directory you are writing your logs to and the directory where the scripts are in are writable by the user that runs the scripts.


## Requirements

This will need to be run as a user which has access to modify the files within each WordPress directory.


## Configuration

There are a few variables which you can configure at the top of the `wp-update-all.sh` script:

`WWW="/var/www"`

You should point this to the directory which holds your WordPress installation directories. It will search recursively from this directory.

`LOG_DIR="/var/www/logs"`

This is the directory where you want the script to write the success/error log files to.

`TIMEZONE="America/Denver"`

This is the time zone which you want the log files to display. See full list [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).


## Additional Note

The `wp-update-all.sh` script will automatically update the WordPress CLI binary to latest version ensuring security flaws are fixed.

