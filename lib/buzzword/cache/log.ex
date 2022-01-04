defmodule Buzzword.Cache.Log do
  use File.Only.Logger

  warn :line_incorrect, {path, line, line_number, env} do
    """
    \nLine incorrect...
    • File: #{inspect(path) |> maybe_break(8)}
    • Line number: #{line_number}
    • Line: #{inspect(line) |> maybe_break(8)}
    • Correct format:
      "<phrase of 3 or more chars>,<integer points greater than 0>"
    #{from(env, __MODULE__)}
    """
  end
end
