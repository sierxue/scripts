#!/usr/bin/env bash

# Empty the Trash/Recycle Bin.
cd .local/share/Trash/ && cd files && rm -rf *
# Purge temporary files.
sudo systemctl start systemd-tmpfiles-clean
# Clean up APT cache in Ubuntu
sudo apt clean
# Get rid of packages (including old kernels) that are no longer required.
sudo apt autoremove --purge

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
