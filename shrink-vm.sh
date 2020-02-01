#!/usr/bin/env bash

# Empty the Trash/Recycle Bin.
cd $HOME/.local/share/Trash/ && cd files && rm -rf *
# Purge temporary files.
sudo systemctl start systemd-tmpfiles-clean
# Clean up APT cache in Ubuntu
sudo apt clean
# Get rid of packages (including old kernels) that are no longer required.
sudo apt autoremove --purge
# Remove old kernels.
sudo apt purge $(for tag in "linux-image" "linux-headers"; do dpkg-query -W -f'${Package}\n' "$tag-[0-9]*.[0-9]*.[0-9]*" | sort -V | awk 'index($0,c){exit} //' c=$(uname -r | cut -d- -f1,2); done)

# Clear back up for texlive packages.
if [ -d /usr/local/texlive ]; then
    sudo tlmgr backup --clean --all
fi

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done
