#!/bin/bash
# This script used to bootstrap a chef-solo install of the itdrc Snap IT cookbook.
# For debian 8/8.5 machiens ONLY!!!!
#   'curl -sSL  https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/install.sh | sudo bash'
# or:
#   'wget -qO-  https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/install.sh  | sudo bash'

# Fyi, i borrowed inspiration for this script for the docker folk, thanks guys!

set -e
CHEF_SOLO_DIR='/root/itdrc-sanp-it-installer'
BERKS_URL="https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/Berksfile"
SOLO_JSON_URL="https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/solo.json"
SOLO_RB_URL="https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/solo.rb"
CHEF_DK_URL="https://packages.chef.io/files/current/chefdk/1.3.10/debian/8/chefdk_1.3.10-1_amd64.deb"
RUN_CHEF_URL="https://raw.githubusercontent.com/DoctorOgg/chef-itdrc-snap-it/master/chef-solo-install/run-chef.sh"

URLS=( $BERKS_URL $SOLO_JSON_URL $SOLO_RB_URL $CHEF_DK_URL $RUN_CHEF_URL)
command_exists() {
    command -v "$@" > /dev/null 2>&1
}

if ! command_exists "curl"; then
  echo "Alright, I dont have curl, i'm going to install curl!"
  apt-get update
  apt-get install -y curl
fi

if ! command_exists "bc"; then
  echo "Alright, I dont have curl, i'm going to install curl!"
  apt-get update
  apt-get install -y bc
fi

# Before we continue, are we running debian 8 or above? Simple test, but better than nothing
if [ -e /etc/debian_version ];  then
  echo "Looks like we are running a flavor of debian, now to check version."
  debian_version=`cat /etc/debian_version`
  if ! [ $(echo "$debian_version >= 8" | bc) -eq 1 ]; then
    echo "Sorry, your ${debian_version}", is too old!
    exit 1
  fi
else
  echo "Hi, it looks like /etc/debian_version, does not exist, so i'm guessing we are not running debian."
  echo "So i'm going to exit now, before we make more mistakes."
  exit 1
fi

if [ -d $CHEF_SOLO_DIR ]; then
  echo "Directory exists: ${CHEF_SOLO_DIR}"
else
  mkdir -v ${CHEF_SOLO_DIR}
fi

if [ -d "${CHEF_SOLO_DIR}/cookbooks" ]; then
  echo "Directory exists: "${CHEF_SOLO_DIR}/cookbooks""
else
  mkdir -v "${CHEF_SOLO_DIR}/cookbooks"
fi

echo "Ok, lets get the required files."
for i in "${URLS[@]}"; do
    file=`echo ${i##*/}`
    if ! [ -e "${CHEF_SOLO_DIR}/$file" ]; then
      curl "${i}" -o "${CHEF_SOLO_DIR}/$file"
    fi
done

echo "Lets ensure run-chef.sh is execuitable"
run_chef_sh=`echo ${RUN_CHEF_URL##*/}`
( cd $CHEF_SOLO_DIR  && chmod +x $run_chef_sh )

echo "Installing Chef DK"
deb=`echo ${CHEF_DK_URL##*/}`
dpkg -i "${CHEF_SOLO_DIR}/${deb}"

echo "Retrieving cookbooks"
(cd $CHEF_SOLO_DIR && berks vendor cookbooks/ )

echo "Alright we got the requirements installed, you should now edit solo.json, then run ./run-chef.sh"

exit 0
