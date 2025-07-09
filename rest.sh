#!/bin/env bash

# get directory of current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# read password
echo -n "Enter encryption password: "
read -s RESTIC_PASSWORD
echo
export RESTIC_PASSWORD

# create repo if not exist
if [ ! -d "$SCRIPT_DIR/restic" ]; then
    echo "Creating restic repository in $SCRIPT_DIR/restic..."
    restic -r "$SCRIPT_DIR/restic" init
fi

# do backup
restic -r "$SCRIPT_DIR/restic" backup \
  --exclude ~/.cache \
  --exclude ~/Downloads \
  ~/

# do cleanup
restic -r "$SCRIPT_DIR/restic" forget --keep-last 10
restic -r "$SCRIPT_DIR/restic" prune
