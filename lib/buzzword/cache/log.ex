defmodule Buzzword.Cache.Log do
  use File.Only.Logger
  use PersistConfig

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
    • App: #{Mix.Project.config()[:app]}
    • Library: #{@app}
    • Module: #{inspect(__MODULE__)}
    """
  end
end
