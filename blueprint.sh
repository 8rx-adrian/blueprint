#!/bin/bash
set -euo pipefail

clear
cat << "EOF"
================================================
       ____  __    _____  ______  ____  _____   ________
   / __ \/ /   /   \ \/ / __ \/ __ \/  _/ | / /_  __/
  / /_/ / /   / /| |\  / /_/ / / / // //  |/ / / /   
 / ____/ /___/ ___ |/ / ____/ /_/ // // /|  / / /    
/_/   /_____/_/  |_/_/_/    \____/___/_/ |_/ /_/     
                                                                  
              POWERED BY BLUEPRINT ™
================================================
EOF


# Tested on Ubuntu/Debian

set -e

echo "=== UPGRADING YOUR SYSTEM ==="
sudo apt update -y && sudo apt upgrade -y

echo "=== IDefine your Pterodactyl directory ==="
export PTERODACTYL_DIRECTORY=/var/www/pterodactyl


echo "=== Install curl, wget and unzip if you haven't already ==="
sudo apt install -y curl wget unzip



echo "=== Navigate to your Pterodactyl directory ==="
cd $PTERODACTYL_DIRECTORY



echo "=== Download and unzip Blueprint's latest release ==="
wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O $PTERODACTYL_DIRECTORY/release.zip
unzip -o release.zip


echo "=== Install dependencies ==="
sudo apt install -y ca-certificates curl git gnupg unzip wget zip



echo "=== Add Node.js apt repository ==="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
sudo apt update"
sudo apt install -y nodejs


echo "=== cd into Pterodactyl, install yarn and node dependencies ==="
cd $PTERODACTYL_DIRECTORY
npm i -g yarn
yarn install

echo "=== Creates a .blueprintrc file in your Pterodactyl directory ==="
touch $PTERODACTYL_DIRECTORY/.blueprintrc


echo "=== Writes data to your .blueprintrc file ==="
echo \
'WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";' > $PTERODACTYL_DIRECTORY/.blueprintrc
 setup ==="


echo "=== Give blueprint.sh execute permissions ==="
chmod +x $PTERODACTYL_DIRECTORY/blueprint.sh


echo "=== RUNNING BLUEPRINT SETUP  ==="
bash $PTERODACTYL_DIRECTORY/blueprint.sh


echo "âœ… BLUEPRINT ðŸ’™ installation complete!"
echo "âž¡ï¸ Run 'sudo systemctl status blueprint' then check your status.
