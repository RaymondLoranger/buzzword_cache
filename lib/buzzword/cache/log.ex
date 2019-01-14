defmodule Buzzword.Cache.Log do
  use File.Only.Logger

  warn :line_incorrect, {path, line, index} do
    """
    \nLine incorrect...
    • File:
      #{path}
    • Line number: #{index}
    • Line:
      #{inspect(line, pretty: true)}
    • Correct format:
      "<phrase of 3 or more chars>,<integer points greater than 0>"
    #{from()}
    """
  end
end
