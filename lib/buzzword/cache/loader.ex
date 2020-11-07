defmodule Buzzword.Cache.Loader do
  @moduledoc """
  Reads a CSV file of buzzwords (phrases and their respective point values).
  Returns a map containing the phrases as keys and the points as values.
  """

  use PersistConfig

  alias Buzzword.Cache.Log

  @default_path get_env(:buzzwords_default_path)

  @doc """
  Reads a CSV file of buzzwords (phrases and their respective point values).
  Returns a map containing the phrases as keys and the points as values.
  """
  @spec read_buzzwords :: %{String.t() => pos_integer}
  def read_buzzwords do
    import String, only: [trim: 1]

    path = path() |> Path.expand()

    for {line, index} <- path |> File.stream!() |> Enum.with_index(1) do
      with [phrase, value] <- line |> String.split(",") |> Enum.map(&trim/1),
           length when length >= 3 <- String.length(phrase),
           {points, ""} when points > 0 <- Integer.parse(value) do
        {phrase, points}
      else
        _error -> {:error, Log.warn(:line_incorrect, {path, line, index})}
      end
    end
    |> Map.new()
    |> Map.delete(:error)
  end

  ## Private functions

  @spec path :: Path.t()
  defp path, do: get_env(:buzzwords_path, @default_path)
end
