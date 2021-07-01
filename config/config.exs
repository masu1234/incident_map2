# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :incident_map2,
  ecto_repos: [IncidentMap2.Repo]

# Configures the endpoint
config :incident_map2, IncidentMap2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o/DuxPMDEECM5kDCxSWmWp6a9U4Y0IM2ufWE0OPXLHJMOFA2uBUK5J2CwwJRprGT",
  render_errors: [view: IncidentMap2Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: IncidentMap2.PubSub,
  live_view: [signing_salt: "7qTOXgGP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
