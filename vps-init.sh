# VPS install script
# For CentOS 8

# Run it from inside the VPS with
# curl -fsS https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init.sh | bash
# or
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sarimarton/vps-init/master/vps-init.sh?ts=`date +%s`)"

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
systemctl start docker
usermod -aG docker marci
chmod 755 /home/marci
curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install my services
dnf install -y git
git clone --recurse-submodules https://github.com/sarimarton/vps-init.git
cd vps-init

# Add cron job for containers to talk back to host
# https://stackoverflow.com/a/63719458/839382
mkfifo $(pwd)/pipe-host
(crontab -l; echo "@reboot while true; do eval \"\$(cat $(pwd)/pipe-host)\"; done") 2> /dev/null | sort | uniq | crontab -
# Shell exec on host from container: echo "<command>" > [volume bind]/pipe

# Spin up and add spin-up to crontab @reboot
launch="/usr/local/bin/docker-compose -f $(pwd)/docker-compose.yml -f $(pwd)/docker-compose.prod.yml up -d --build"
(crontab -l; echo "@reboot $launch") 2> /dev/null | sort | uniq | crontab -
$launch

