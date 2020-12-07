# Based on this tutorial:
# https://geko.cloud/nginx-and-ssl-with-certbot-in-docker-alpine/
FROM nginx:alpine
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev

# This is to work around a certbot install problem down there
# https://github.com/pypa/pipenv/issues/4548#issuecomment-738268219
RUN pip3 install pyopenssl==19.1.0

# ...continuing from the tutorial
RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt

# Another insert: launch nginx, and right after that exec certbot too.
# Certbot works only when nginx is running, and we have to do these in the same
# step to keep in the same process. And we have to have the correct conf already.
# https://github.com/nginxinc/docker-nginx/blob/master/stable/alpine/Dockerfile#L124
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN nohup /docker-entrypoint.sh nginx -g "daemon off;" & \
  certbot \
  -d vacskamati.hu \
  -d srm.tn \
  -d sarimar.tn \
  --nginx --non-interactive --agree-tos \
  -m sarimarton@gmail.com

# Add weekly renew
RUN (crontab -l ; echo "@weekly certbot renew") 2> /dev/null | sort | uniq | crontab -
