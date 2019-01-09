defmodule Buzzword.Cache.Loader do
  @moduledoc """
  Reads a CSV file of buzzwords (phrases) and their respective point values.
  Returns a map containing the buzzwords as keys and the points as values.
  """

  use PersistConfig

  alias Buzzword.Cache.Log

  @path Application.get_env(@app, :buzzwords_path)

  @doc """
  Reads a CSV file of buzzwords (phrases) and their respective point values.
  Returns a map containing the buzzwords as keys and the points as values.
  """
  @spec read_buzzwords :: %{String.t() => pos_integer}
  def read_buzzwords do
    import File, only: [stream!: 1]
    import Stream, only: [with_index: 2]
    import String, only: [split: 2, trim: 1]

    for {line, index} <- @path |> stream!() |> with_index(1) do
      with [phrase, value] <- line |> split(",") |> Enum.map(&trim/1),
           length when length >= 3 <- String.length(phrase),
           {points, ""} when points > 0 <- Integer.parse(value) do
        {phrase, points}
      else
        _error -> {:error, Log.warn(:line_incorrect, {@path, line, index})}
      end
    end
    |> Map.new()
    |> Map.delete(:error)
  end
end
