defmodule Buzzword.Cache.Loader do
  @moduledoc """
  Reads a CSV file of buzzwords (phrases and their respective point values).
  Returns a map containing the phrases as keys and the points as values.
  """

  use PersistConfig

  alias Buzzword.Cache.Log

  @def_buzzwords_path get_env(:def_buzzwords_path)

  @doc """
  Reads a CSV file of buzzwords (phrases and their respective point values).
  Returns a map containing the phrases as keys and the points as values.
  """
  @spec read_buzzwords :: %{String.t() => pos_integer}
  def read_buzzwords do
    import String, only: [trim: 1]

    path = path() |> Path.expand()

    for {line, index} <- File.stream!(path) |> Enum.with_index(1) do
      with [phrase, value] <- String.split(line, ",") |> Enum.map(&trim/1),
           length when length >= 3 <- String.length(phrase),
           {points, ""} when points > 0 <- Integer.parse(value) do
        {phrase, points}
      else
        _ -> {:error, Log.error(:line_incorrect, {path, line, index, __ENV__})}
      end
    end
    |> Map.new()
    |> Map.delete(:error)
  end

  ## Private functions

  @spec path :: Path.t()
  defp path, do: get_env(:buzzwords_path, @def_buzzwords_path)
end
