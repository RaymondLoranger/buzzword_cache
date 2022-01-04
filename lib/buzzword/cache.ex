# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Cache do
  @moduledoc """
  Buzzword Cache for the _Multi-Player Bingo_ game.

  ##### Based on the course [Multi-Player Bingo](https://pragmaticstudio.com/courses/unpacked-bingo) by Mike and Nicole Clark.
  """

  alias __MODULE__.Server

  @typedoc "A tuple of phrase and points"
  @type buzzword :: {phrase, points}
  @typedoc "A map assigning points to phrases"
  @type buzzwords :: %{phrase => points}
  @typedoc "Buzzword phrase"
  @type phrase :: String.t()
  @typedoc "Buzzword points"
  @type points :: pos_integer

  @doc """
  Returns a map of buzzwords.

  ## Examples

      iex> alias Buzzword.Cache
      iex> %{"Low-Hanging Fruit" => points} = Cache.get_buzzwords()
      iex> points
      300
  """
  @spec get_buzzwords :: buzzwords
  def get_buzzwords, do: GenServer.call(Server, :get_buzzwords)

  @doc """
  Refreshes the cache from the configured external file and resets the timer.
  """
  @spec refresh :: :refresh
  def refresh, do: send(Server, :refresh)
end
