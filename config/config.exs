# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :david_hays,
       :translator_url,
       "https://translate.yandex.net/api/v1.5/tr.json"

config :david_hays,
       :translator_key,
       "trnsl.1.1.20181113T122143Z.259317bf7b892603.d7b721f288d8599557981ad1f4bd6ad74d6f5338"

config :david_hays,
       :translator_api,
       DavidHays.YandexTranslateApi

# Configures the endpoint
config :david_hays, DavidHaysWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "K3/WT5pENTQECfqyJJGqXHV59PCqsRDNkOP5QVLIMUUiv/DORhrtK6p2FcNujbth",
  render_errors: [view: DavidHaysWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DavidHays.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
