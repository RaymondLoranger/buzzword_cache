import Config

# config :buzzword_cache, buzzwords_path: "./assets/buzzwords.csv"

config :log_reset, reset?: config_env() in [:prod, :dev]
config :file_only_logger, log?: config_env() in [:prod, :dev]
