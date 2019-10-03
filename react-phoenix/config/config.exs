# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :reddit,
  ecto_repos: [Reddit.Repo]

# Configures the endpoint
config :reddit, Reddit.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jibgk00xwYBxa0rw2+c5j88L6yzuCRHiQIJCTd3ntJk/nOJCT+lcEMuK9RErgEHW",
  render_errors: [view: Reddit.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reddit.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "ebf47114a980c0dcc677",
  client_secret: "5dfe7d3f66f4b467fd878e782dfbe94f8d0b7bde"
