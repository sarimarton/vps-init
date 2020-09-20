# VPS install script
# For CentOS 8

# Run it from inside the VPS with
# curl -fsS https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init.sh | bash

# This script assumes that you're in an SSH session of a fresh CentOS 8 install
# with the root user.

# Setup users (check if there's pre-defined passwords)
[ -z "$ROOTPW" ] && passwd root || echo -e "$ROOTPW\n$ROOTPW" | passwd root
adduser marci
[ -z "$MARCIPW" ] && passwd marci || echo -e "$MARCIPW\n$MARCIPW" | passwd marci
usermod -aG wheel marci

# Install stuff
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
# dnf install -y gcc-c++ make
dnf install -y mc nginx git nodejs

# Build up marci stuff
runuser -l  marci -c 'mkdir ~/projects'
runuser -l  marci -c 'mkdir ~/static'
runuser -l  marci -c 'mkdir ~/tmp'

# Final touch
systemctl enable nginx
systemctl start nginx
