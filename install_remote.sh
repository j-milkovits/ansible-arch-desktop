#!/bin/bash

# assumes that this is run as a sudo/wheel user (not root)
sudo pacman -Sy --noconfirm
sudo pacman -S ansible sudo git --noconfirm

USERNAME=$(whoami)

ROLES="base"

# -K: --ask-become-pass
ansible-pull -K -U https://github.com/j-milkovits/ansible-arch-desktop -e "username=$USERNAME" -e "roles_to_execute=$ROLES"
