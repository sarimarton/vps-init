# VPS install script
# For CentOS 8

# Run it from inside the VPS with
# curl -fsS https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init.sh | bash

# Or from outside:
# ssh root@server.com 'set -s pipefail ; curl -fsS https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init.sh | bash'

# Setup up users
echo Setting up users...

# Set password with checking if there's a preset value
[ -z "$ROOTPW" ] && passwd root || echo -e "$ROOTPW\n$ROOTPW" | passwd root
adduser marci

# Set password with checking if there's a preset value
[ -z "$MARCIPW" ] && passwd marci || echo -e "$MARCIPW\n$MARCIPW" | passwd marci
usermod -aG wheel marci

# Install utilities
echo Installing utilities...

dnf install -y mc

# Install nginx
echo Installing nginx...

dnf install -y nginx

