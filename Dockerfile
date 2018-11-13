FROM bitwalker/alpine-elixir-phoenix:1.7.3

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app
