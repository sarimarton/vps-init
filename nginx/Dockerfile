# https://geko.cloud/nginx-and-ssl-with-certbot-in-docker-alpine/
FROM nginx:alpine
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev

# This is inserted in the middle to workaround a problem down there
# https://github.com/pypa/pipenv/issues/4548#issuecomment-738268219
RUN pip3 install pyopenssl==19.1.0

RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt

RUN nginx

RUN certbot \
  -d vacskamati.hu \
  -d srm.tn \
  -d sarimar.tn \
  --nginx --non-interactive --agree-tos \
  -m sarimarton@gmail.com

RUN (crontab -l ; echo "@weekly certbot renew") 2> /dev/null | sort | uniq | crontab -
