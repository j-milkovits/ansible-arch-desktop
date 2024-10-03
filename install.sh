#!/bin/bash

# assumes that this is run as a sudo/wheel user (not root)
sudo pacman -Sy --noconfirm
sudo pacman -S ansible sudo --noconfirm

# --- ROLES ---
OPTIONS=("base" "development" "wayland") # options for roles
SELECTED=("x" "x" "x") # save selected roles
highlight=0 # initial highlight position
done=false # done flag

print_menu() {
  clear
  echo "Select the roles to install."
  echo "Use the arrow keys to move, space to select/unselect, and Enter to confirm."
  
  for i in "${!OPTIONS[@]}"; do
    if [[ ${SELECTED[$i]} == "x" ]]; then
      marker="[x]"
    else
      marker="[ ]"
    fi

    if [[ $i == $highlight ]]; then
      echo -e "\e[1m$marker ${OPTIONS[$i]}\e[0m"  # highlight selected option
    else
      echo "$marker ${OPTIONS[$i]}"
    fi
  done
}

while [ "$done" = false ]; do
  print_menu

  read -rsn1  # read 1 character

  case "$REPLY" in
    $'\x1b')
      read -rsn2  # read 2 more characters
      case "$REPLY" in
        '[A')  # up arrow
          ((highlight--))
          if [[ $highlight -lt 0 ]]; then
            highlight=$((${#OPTIONS[@]} - 1))
          fi
          ;;
        '[B')  # down arrow
          ((highlight++))
          if [[ $highlight -ge ${#OPTIONS[@]} ]]; then
            highlight=0
          fi
          ;;
      esac
      ;;
    ' ')  # spacebar to select/unselect
      echo "Reached Space Bar Case"
      if [[ ${SELECTED[$highlight]} == "x" ]]; then
        SELECTED[$highlight]=""
      else
        SELECTED[$highlight]="x"
      fi
      ;;
    '')  # enter key to confirm
      done=true
      ;;
  esac
done

clear
echo "The following roles will be installed:"
ROLES=()
for i in "${!OPTIONS[@]}"; do
  if [[ ${SELECTED[$i]} == "x" ]]; then
    echo "- ${OPTIONS[$i]}"
    ROLES+=("${OPTIONS[$i]}")
  fi
done

USERNAME=$(whoami)

# check for git variables if development has been selected
search_string="development"
if [[ " ${ROLES[@]} " =~ " ${search_string} " ]]; then
  # query for github user name and email and save it to variable
  read -p "Enter your GitHub username: " GITHUB_USERNAME
  read -p "Enter your GitHub email: " GITHUB_EMAIL
fi

# convert bash array to comma-separated string
roles_to_execute=$(IFS=,; echo "${ROLES[*]}")

ansible-playbook local.yml \
  --ask-become-pass \
  -e "username=$USERNAME" \
  -e "roles_to_execute=$roles_to_execute" \
  -e "github_username=$GITHUB_USERNAME" \
  -e "github_email=$GITHUB_EMAIL"
