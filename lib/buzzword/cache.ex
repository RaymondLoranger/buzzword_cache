# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Cache do
  use PersistConfig

  @course_ref get_env(:course_ref)

  @moduledoc """
  Buzzword Cache for the _Multi-Player Bingo_ game. Returns a map of buzzwords.
  \n##### #{@course_ref}
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
  def get_buzzwords do
    GenServer.call(Server, :get_buzzwords)
  end

  @doc """
  Refreshes the cache from the configured external source and resets the timer.
  """
  @spec refresh :: :refresh
  def refresh, do: send(Server, :refresh)
end
