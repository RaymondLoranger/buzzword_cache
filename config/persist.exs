use Mix.Config

config :buzzword_cache, buzzwords_path: "#{File.cwd!()}/assets/buzzwords.csv"
config :buzzword_cache, refresh_interval: :timer.minutes(60)
