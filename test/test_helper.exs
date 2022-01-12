# Disable file logging for tests.
Application.put_env(:file_only_logger, :level, :none, persistent: true)
ExUnit.start()
