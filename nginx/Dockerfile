# Based on this tutorial:
# https://geko.cloud/nginx-and-ssl-with-certbot-in-docker-alpine/
FROM nginx:1.19.5-alpine
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev

# This is to work around a certbot install problem down there
# https://github.com/pypa/pipenv/issues/4548#issuecomment-738268219
RUN pip3 install pyopenssl==19.1.0

# ...continuing from the tutorial
RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt

# There might be other volumes in docker-compose, but the certs should for sure
# be persisted outside.
VOLUME ["/etc/letsencrypt"]

# Add weekly renewal of letsencrypt
RUN (crontab -l ; echo "@weekly certbot renew") 2> /dev/null | sort | uniq | crontab -

# Install certs on image start... Build-time cert fetch is not possible, due to
# the ports being closed, and certbot challenge will fail -
# https://stackoverflow.com/questions/38981826/docker-publish-ports-during-build
# Here we just extend the nginx:alpine ENTRYPOINT and CMD to have the cert fetch
# first. Super awkward, I know - but fancy at the same time! ^_^
# https://github.com/nginxinc/docker-nginx/blob/master/stable/alpine/Dockerfile#L124
ENTRYPOINT []
CMD certbot --nginx --non-interactive --agree-tos --keep-until-expiring --expand \
  -m sarimarton@gmail.com \
  -d vacskamati.hu,srm.tn,files.srm.tn,sarimar.tn & \
  /docker-entrypoint.sh nginx -g "daemon off;"
