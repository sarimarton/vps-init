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

# Docker volume backup-restore CLI: https://github.com/loomchild/volume-backup
glopser-backup:
	@docker run -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup backup - > ./aws-data/glopser-vol-${ENV}.tar.bz2 \
		&& docker run --rm -v ${PWD}/aws-data:/aws -v ${PWD}/.aws:/root/.aws amazon/aws-cli s3 cp ./glopser-vol-${ENV}.tar.bz2 s3://glopser-org

glopser-restore:
	@docker run --rm -v ${PWD}/aws-data:/aws -v ${PWD}/.aws:/root/.aws amazon/aws-cli s3 cp s3://glopser-org/glopser-vol-${ENV}.tar.bz2 . \
		&& cat ./aws-data/glopser-vol-${ENV}.tar.bz2 | docker run -i -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup restore -

start:
	@docker-compose up -d --build

stop:
	@docker-compose down

.DEFAULT_GOAL := start

