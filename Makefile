default:
	make clean
	make docker-build
	sh scripts/install_laravel.sh
	docker-compose run --rm -it app /bin/bash -c 'mkdir -p storage/framework/{sessions,views,cache} && chmod -R 775 storage/framework'
	docker-compose run --rm -it app /bin/bash -c 'mkdir -p storage/logs && chmod -R 775 storage/logs'
	docker-compose run --rm -it app /bin/bash -c 'composer install && npm install'
	docker-compose run --rm -it app /bin/bash -c 'php artisan migrate'
	docker-compose run --rm -it app /bin/bash -c 'npm run build'

build: docker-build

docker-build:
	docker-compose build --no-cache

start:
	# Use the enhanced run script so we can enable optional services
	# Pass extras via: make start EXTRAS="rabbit msql" (or leave empty for base stack)
	./scripts/run.sh $(EXTRAS)
ifeq ($(OS),Windows_NT)
	scripts\open.bat
else
	./scripts/open.sh
endif

# Convenience shortcuts that leverage the run script
start-all:
	EXTRAS="rabbit msql" $(MAKE) start

reinstall:
	make clean
	make docker-build
	docker-compose run --rm -it app /bin/bash -c 'mkdir -p storage/framework/{sessions,views,cache} && chmod -R 775 storage/framework'
	docker-compose run --rm -it app /bin/bash -c 'mkdir -p storage/logs && chmod -R 775 storage/logs'
	docker-compose run --rm -it app /bin/bash -c 'rm -rfv vendor && composer install'
	docker-compose run --rm -it app /bin/bash -c 'php artisan migrate'
	docker-compose run --rm -it app /bin/bash -c 'rm -rfv node_modules && npm install'
	docker-compose run --rm -it app /bin/bash -c 'npm run build'

stop:
	docker-compose stop

down:
	docker-compose down

restart:
	docker-compose stop
	docker-compose up -d

clean:
	docker-compose down -v

cli:
	docker-compose run --rm -it app /bin/bash

test:
	docker-compose run --rm -it app /bin/bash -c 'php artisan test'

log:
	docker-compose logs -f app
