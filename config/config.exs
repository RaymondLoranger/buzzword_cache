import Config

# Mix messages in colors...
# config :elixir, ansi_enabled: true

import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"

import_config "persist_buzzwords_default_path.exs"
import_config "persist_course_ref.exs"
