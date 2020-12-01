# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Cache do
  @moduledoc """
  Buzzword Cache for the _Multi-Player Bingo_ game. Returns a map of buzzwords.

  ##### Based on the course [Multi-Player Bingo](https://pragmaticstudio.com/courses/unpacked-bingo) by Mike and Nicole Clark.
  """

  alias __MODULE__.Server

  @doc """
  Returns a map of buzzwords.

  ## Examples

      iex> alias Buzzword.Cache
      iex> %{"Low-Hanging Fruit" => points} = Cache.get_buzzwords()
      iex> points
      300
  """
  @spec get_buzzwords :: %{String.t() => pos_integer}
  def get_buzzwords, do: GenServer.call(Server, :get_buzzwords)

  @doc """
  Refreshes the cache from the configured external file and resets the timer.
  """
  @spec refresh :: :refresh
  def refresh, do: send(Server, :refresh)
end
