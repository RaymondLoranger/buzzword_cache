defmodule Buzzword.Cache.Log do
  use File.Only.Logger

  error :line_incorrect, {path, line, index, env} do
    """
    \nLine incorrect...
    • Inside function:
      #{fun(env)}
    • File:
      #{path}
    • Line number: #{index}
    • Line:
      #{inspect(line)}
    • Correct format:
      "<phrase of 3 or more chars>,<integer points greater than 0>"
    #{from()}
    """
  end
end
