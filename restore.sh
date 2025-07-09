#!/bin/env bash

# get directory of current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# read password
echo -n "Enter encryption password: "
read -s RESTIC_PASSWORD
echo
export RESTIC_PASSWORD

echo "IMPORTANT: your data will be deleted if backup wants to overwrite it! Press ctrl+c and do not enter password if unsure!"
sudo restic -r "$SCRIPT_DIR/restic" restore latest --target /
