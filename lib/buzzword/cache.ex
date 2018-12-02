# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the course "Multi-Player Bingo" by Mike and Nicole Clark. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Buzzword.Cache do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Buzzword Cache for the _Multi-Player Bingo_ game. Returns a map of buzzwords.

  ##### #{@course_ref}
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
  @spec get_buzzwords :: map
  def get_buzzwords do
    GenServer.call(Server, :get_buzzwords)
  end
end
