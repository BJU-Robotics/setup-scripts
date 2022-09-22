
# Don't allow errors to propagate
set -e

# Install the GUI
# https://itsfoss.com/install-gui-ubuntu-server/
apt update && apt install curl gnupg2 lsb-release
apt install ubuntu-desktop --no-install-recommends
apt install lightdm

# Install ROS2
# http://docs.ros.org.ros.informatik.uni-freiburg.de/en/foxy/Installation/Ubuntu-Install-Debians.html
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

apt update
apt upgrade
apt install ros-foxy-desktop