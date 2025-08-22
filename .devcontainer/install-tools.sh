# DevContainer System installation file
# Please check https://gitlab.lis-lab.fr/sicomp/devcontainer for more informations.
# Feel free to contact us: https://mattermost.lis-lab.fr/cluster/

#!/bin/bash

#check pip is installed
command -v pip &> /dev/null && pip install -r .devcontainer/requirements.txt || echo "pip is not installed. Skipping Python package installation."

echo "tzdata tzdata/Areas select Europe" | debconf-set-selections
echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt update -y
DEBIAN_FRONTEND=noninteractive apt install jq -y
DEBIAN_FRONTEND=noninteractive apt install squashfs-tools -y
DEBIAN_FRONTEND=noninteractive apt install curl -y
DEBIAN_FRONTEND=noninteractive apt install wget -y
DEBIAN_FRONTEND=noninteractive apt install git -y



