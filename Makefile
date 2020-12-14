# https://lithic.tech/blog/2020-05/makefile-dot-env
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

install:
	@cp .env.${ENV} .env \
		&& echo "[default]\n\
	aws_access_key_id = ${AWS_ACCESS_KEY_ID}\n\
	aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}\n\
	" > ./.aws/credentials

bkup-glopser:
	@docker run -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup backup - > glopser-vol-${ENV}.tar.bz2

restore-glopser:
	@cat glopser-vol-${ENV}.tar.bz2 | docker run -i -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup restore -

start:
	@docker-compose up -d --build

stop:
	@docker-compose down

.DEFAULT_GOAL := start

