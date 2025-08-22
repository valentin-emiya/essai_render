#!/bin/bash

# Define ANSI color escape codes
RED='\033[1;31m'
RESET='\033[0m'
YELLOW='\033[33m'
CYAN='\033[0;36m'
BCYAN='\033[1;36m'

# Define the content to append
welcome_content=$(cat <<EOF
echo ""
echo -e "${RED}______           _____             _        _                     ${RESET}"
echo -e "${RED}|  _  \         /  __ \           | |      (_)                    ${RESET}"
echo -e "${RED}| | | |_____   _| /  \/ ___  _ __ | |_ __ _ _ _ __   ___ _ __ ___ ${RESET}"
echo -e "${RED}| | | / _ \ \ / / |    / _ \| '_ \| __/ _  | | '_ \ / _ \ '__/ __|${RESET}"
echo -e "${RED}| |/ /  __/\ V /| \__/\ (_) | | | | || (_| | | | | |  __/ |  \__ \ ${RESET}"
echo -e "${RED}|___/ \___| \_/  \____/\___/|_| |_|\__\__,_|_|_| |_|\___|_|  |___/${RESET}"
echo -e "\n"
echo -e "GitLab Repo       : ${YELLOW}https://gitlab.lis-lab.fr/sicomp/dcli${RESET}"
echo -e "Tutos             : ${YELLOW}https://gitlab.lis-lab.fr/sicomp/devcontainer_formation${RESET}"
echo -e "Contact us        : ${YELLOW}https://mattermost.lis-lab.fr/cluster${RESET}"
echo ""
EOF
)

# Check and append the welcome content if not already present
if ! grep -q "devcontainer" /root/.bashrc; then
    echo -e "$welcome_content" | tee -a /root/.bashrc > /dev/null
fi

# Check and append WORKDIR export if not already present
if ! grep -q "export WORKDIR=" /root/.bashrc; then
    echo -e 'export WORKDIR=$(pwd)' | tee -a /root/.bashrc > /dev/null
fi

# Check and append PATH for .devcontainer/bin oatg export if not already present
if ! grep -q "export PATH=" /root/.bashrc; then
    echo -e 'export PATH=$PATH:$(pwd)/.devcontainer/dctools' | tee -a /root/.bashrc > /dev/null
fi

# Update requirements.txt
type pip &> /dev/null && pip list --format=freeze > .devcontainer/requirements.txt

#  -- DCTOOLS Bypass --

type pip &> /dev/null && echo 'pip() { if [[ "$1" == "install" ]]; then shift; dc_pip install "$@"; elif [[ "$1" == "uninstall" ]]; then shift; dc_pip uninstall "$@"; else command pip "$@"; fi }' | tee -a /root/.bashrc > /dev/null

# Alias for apt command
echo '
apt() {
    if [[ "$1" == "install" ]]; then
        shift
        dc_apt install "$@"
    elif [[ "$1" == "remove" ]]; then
        shift
        dc_apt remove "$@"
    else
        command apt "$@"
    fi
}
' | tee -a /root/.bashrc > /dev/null