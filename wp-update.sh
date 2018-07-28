#!/bin/bash

WP="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)/wp"

# Upgrade WordPress install
$WP --allow-root core update
$WP --allow-root core update-db

# Upgrade Plugins
$WP --allow-root plugin update --all

# Upgrade Themes
$WP --allow-root theme update --all

