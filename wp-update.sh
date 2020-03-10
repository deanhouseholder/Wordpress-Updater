#!/bin/bash

WP="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)/wp"

# Upgrade WordPress install
$WP core update
$WP core update-db

# Upgrade Plugins
$WP plugin update --all

# Upgrade Themes
$WP theme update --all

