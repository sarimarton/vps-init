.DEFAULT_GOAL := start

bkup-glopser-local:
	@docker run -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup backup - > glopser_archive.tar.bz2

restore-glopser-local:
	@cat glopser-volume.tar.bz2 | docker run -i -v vps-init_glopser-volume:/volume --rm loomchild/volume-backup restore -

start-dev:
	@docker-compose --env-file ./.env.dev up -d --build

start-prod:
	@docker-compose --env-file ./.env.prod up -d --build

start: start-dev

stop:
	@docker-compose down

