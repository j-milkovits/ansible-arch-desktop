#!/bin/bash

# assumes that this is run as a sudo/wheel user (not root)
sudo pacman -Sy --noconfirm
sudo pacman -S ansible sudo dialog --noconfirm

USERNAME=$(whoami)

ROLES="base"

ansible-playbook local.yml --ask-become-pass -e "username=$USERNAME" -e "roles_to_execute=$ROLES"
