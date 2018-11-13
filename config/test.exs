use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tesla, adapter: Tesla.Mock

config :david_hays, :translator_endpoint, "localhost:7070"

config :david_hays,
       :translator_api,
       DavidHays.YandexTranslateApiMock

config :david_hays, DavidHaysWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
