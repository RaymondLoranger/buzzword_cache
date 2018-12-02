defmodule Buzzword.Cache.Loader do
  use PersistConfig

  require Logger

  @buzzwords_path Application.get_env(@app, :buzzwords_path)

  @doc """
  Reads a CSV file of buzzwords (phrases) and their respective point values.
  Returns a map containing the buzzwords as keys and the points as values.
  """
  @spec read_buzzwords :: map
  def read_buzzwords do
    import File, only: [stream!: 1]
    import Stream, only: [with_index: 2]
    import String, only: [split: 2, trim: 1]

    for {line, index} <- @buzzwords_path |> stream!() |> with_index(1) do
      with [phrase, value] <- line |> split(",") |> Enum.map(&trim/1),
           {points, ""} when points > 0 <- Integer.parse(value) do
        {phrase, points}
      else
        _error ->
          unless Mix.env() == :test, do: warn(line, index)
          {:error, line}
      end
    end
    |> Map.new()
    |> Map.delete(:error)
  end

  ## Private functions

  @spec warn(String.t(), pos_integer) :: :ok
  defp warn(line, index) do
    """
    \nFile:
    #{@buzzwords_path}
    Row ##{index} is invalid:
    #{inspect(line)}
    """
    |> Logger.warn()
  end
end
