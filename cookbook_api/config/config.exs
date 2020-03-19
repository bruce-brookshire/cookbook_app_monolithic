# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cookbook,
  ecto_repos: [Cookbook.Repo]

# Configures the endpoint
config :cookbook, CookbookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HBSExTHQc8vLXEE11yAJT5eIMOQdpDlqF655/8tpdDUJVJe7ambBx+VieQcONyU2",
  render_errors: [view: CookbookWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Cookbook.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cookbook, Cookbook.Auth,
      issuer: "Cookbook",
      secret_key: "umpN7XAsdpm1GopIIydlZj2GgVnXQ3j48cA2DxWyBchVsn5mXNJs9+JDBBqdX3LN"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
