# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :septa_gong,
  ecto_repos: [SeptaGong.Repo]

# Configures the endpoint
config :septa_gong, SeptaGongWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0JhFvJ/TWqPAgj2ICABeIHMHzcxNRFIS6Z2YFghmKL4Uz1dLIyha9LUvR9Gt6VMY",
  render_errors: [view: SeptaGongWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SeptaGong.PubSub,
  live_view: [signing_salt: "cGPkeQtO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
