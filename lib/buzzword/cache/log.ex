defmodule Buzzword.Cache.Log do
  use File.Only.Logger

  warn :row_incorrect, {path, line, index} do
    """
    \nFile:
    #{path}
    Row ##{index} is incorrect:
    #{inspect(line)}
    """
  end
end
