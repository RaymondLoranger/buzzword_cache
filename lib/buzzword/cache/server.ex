defmodule Buzzword.Cache.Server do
  @moduledoc """
  A process that loads a map of buzzwords from an external source
  and caches it for expedient access. The cache is automatically
  refreshed every hour.
  """

  use GenServer
  use PersistConfig

  alias __MODULE__
  alias Buzzword.Cache.Loader

  @type from :: GenServer.from()

  @refresh_interval :timer.minutes(60)

  @spec start_link(term) :: GenServer.on_start()
  def start_link(:ok), do: GenServer.start_link(Server, :ok, name: Server)

  ## Private functions

  @spec schedule_refresh :: reference
  defp schedule_refresh,
    do: self() |> Process.send_after(:refresh, @refresh_interval)

  ## Callbacks

  @spec init(term) :: {:ok, map}
  def init(:ok) do
    schedule_refresh()
    {:ok, Loader.read_buzzwords()}
  end

  @spec handle_call(term, from, map) :: {:reply, map, map}
  def handle_call(:get_buzzwords, _from, buzzwords) do
    {:reply, buzzwords, buzzwords}
  end

  @spec handle_info(term, map) :: {:noreply, map}
  def handle_info(:refresh, _buzzwords) do
    schedule_refresh()
    {:noreply, Loader.read_buzzwords()}
  end
end
