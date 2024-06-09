#!/bin/bash

# assumes that this is run as a sudo/wheel user (not root)
sudo pacman -Sy --noconfirm
sudo pacman -S ansible sudo --noconfirm

USERNAME=$(whoami)

ansible-playbook local.yml --ask-become-pass -e "username=$USERNAME"
