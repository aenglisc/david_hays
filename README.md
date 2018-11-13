# David Hays [![Build Status](https://travis-ci.org/aenglisc/david_hays.svg?branch=master)](https://travis-ci.org/aenglisc/david_hays)

**Test task for 404 group: a simple chat with real-time ru-en translation via yandex translate API**

* translates from Russian into English (almost like [David Hays](https://en.wikipedia.org/wiki/David_G._Hays) himself)
* phrases are limited to 280 characters

## Requirements

* docker
* docker-compose
* make

## Instructions

* `make setup` to install
* `make start` to run the app, visit [localhost:4000](http://localhost:4000)
* `make stop` to stop
* `make test` to run tests
* `make start-interactive` to run in interactive mode
