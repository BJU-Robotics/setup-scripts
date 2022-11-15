#!/bin/bash

# Don't allow errors to propagate
set -e

# Stop unattended upgrades
systemctl stop unattended-upgrades.service

# Install the GUI
# https://itsfoss.com/install-gui-ubuntu-server/
apt update && apt install curl gnupg2 lsb-release -y
apt install ubuntu-desktop --no-install-recommends -y
#apt install lightdm -y

# Install other dependencies
apt install openssh-server -y 

# Install ROS2
# http://docs.ros.org.ros.informatik.uni-freiburg.de/en/foxy/Installation/Ubuntu-Install-Debians.html
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

apt update
apt upgrade
sudo apt install ros-galactic-ros-base # apt install ros-foxy-desktop -y
sudo apt install ros-dev-tools 

# https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart
# Password in sharing document
adduser bjurobotics
usermod -aG sudo bjurobotics

cp bjurobotics.pub /home/bjurobotics/.ssh/authorized_keys
chown bjurobotics:bjurobotics /home/bjurobotics/.ssh/authorized_keys
chmod 600 /home/bjurobotics/.ssh/authorized_keys
# Private key in shared files

echo "Install complete. Please reboot the system."
