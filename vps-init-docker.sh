# VPS install script
# For CentOS 8

# Run it from inside the VPS with
# curl -fsS https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init-docker.sh | bash

# This script assumes that you're in an SSH session of a fresh CentOS 8 install
# with the root user.

# Setup users (check if there's pre-defined passwords)
[ -z "$ROOTPW" ] && passwd root || echo -e "$ROOTPW\n$ROOTPW" | passwd root
adduser marci
[ -z "$MARCIPW" ] && passwd marci || echo -e "$MARCIPW\n$MARCIPW" | passwd marci
usermod -aG wheel marci

# Install Docker according to
# https://blog.ssdnodes.com/blog/getting-started-docker-vps/
curl -sS https://get.docker.com/ | sh
systemctl enable docker
sudo usermod -aG docker marci
curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
