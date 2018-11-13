start:
	docker-compose up -d

stop:
	docker-compose down

build:
	docker-compose build app

install:
	docker-compose run --rm app mix deps.get

install-assets:
	docker-compose run --rm app bash -c "cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development"

compile:
	docker-compose run --rm app bash -c "mix do compile, phx.digest"

start-interactive:
	docker-compose run --rm --service-ports app iex -S mix phx.server

test:
	docker-compose run --rm app mix test

setup: build install install-assets compile

.PHONY: test
