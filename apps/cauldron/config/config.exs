# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cauldron,
  namespace: Cauldron

# Configures the endpoint
config :cauldron, CauldronWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nfK/H6Tuwpxr0L+DsLzqsweY/aICul/QoJOs8l8rnOYDqSVLmpUWAg8KQd6SxXRr",
  render_errors: [view: CauldronWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cauldron.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
