# Disables file logging for tests so only startup is reported.
Application.put_env(:file_only_logger, :level, :none, persistent: true)
ExUnit.start()
