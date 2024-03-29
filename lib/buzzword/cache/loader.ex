defmodule Buzzword.Cache.Loader do
  @moduledoc """
  Reads a CSV file of buzzwords (phrases and their assigned point values).
  Returns a map containing the phrases as keys and the points as values.
  """

  use PersistConfig

  alias Buzzword.Cache.Log
  alias Buzzword.Cache

  @default_path get_env(:default_buzzwords_path) |> Path.expand()

  @doc """
  Reads a CSV file of buzzwords (phrases and their assigned point values).
  Returns a map containing the phrases as keys and the points as values.

  ## Examples

      iex> alias Buzzword.Cache.Loader
      iex> %{"Low-Hanging Fruit" => points} = Loader.read_buzzwords()
      iex> points
      300
  """
  @spec read_buzzwords :: Cache.buzzwords()
  def read_buzzwords do
    import String, only: [trim: 1]

    path = buzzwords_path() |> Path.expand()

    for {line, index} <- File.stream!(path) |> Enum.with_index(1), into: %{} do
      with [phrase, value] <- String.split(line, ",") |> Enum.map(&trim/1),
           length when length >= 3 <- String.length(phrase),
           {points, ""} when points > 0 <- Integer.parse(value) do
        {phrase, points}
      else
        _ ->
          :ok = Log.warning(:line_incorrect, {path, line, index, __ENV__})
          {:error, :line_incorrect}
      end
    end
    |> Map.delete(:error)
  end

  ## Private functions

  @spec buzzwords_path :: Path.t()
  defp buzzwords_path, do: get_env(:buzzwords_path, @default_path)
end
