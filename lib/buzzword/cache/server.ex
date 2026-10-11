defmodule Buzzword.Cache.Server do
  @moduledoc """
  A process that loads a buzzwords map from an external file and caches it
  for expedient access. The cache is automatically refreshed every hour.
  """

  use GenServer

  alias __MODULE__
  alias Buzzword.Cache.{Loader, Log}
  alias Buzzword.Cache

  @typedoc "Server state"
  @type state :: {Cache.buzzwords(), reference}

  @refresh_interval :timer.minutes(60)

  @spec start_link(term) :: GenServer.on_start()
  def start_link(_init_arg = :ok),
    do: GenServer.start_link(Server, :ok, name: Server)

  ## Callbacks

  @spec init(term) :: {:ok, state}
  def init(_init_arg = :ok), do: {:ok, state()}

  @spec handle_call(atom, GenServer.from(), state) ::
          {:reply, Cache.buzzwords(), state}
  def handle_call(:get_buzzwords, _from, {buzzwords, _timer_ref} = state),
    do: {:reply, buzzwords, state}

  @spec handle_info(term, state) :: {:noreply, state}
  def handle_info(:refresh, {_buzzwords, timer_ref} = _state) do
    Process.cancel_timer(timer_ref) |> log_refresh()
    {:noreply, state()}
  end

  def handle_info(_message, state), do: {:noreply, state}

  ## Private functions

  @spec state :: state
  defp state do
    {Loader.read_buzzwords(),
     self() |> Process.send_after(:refresh, @refresh_interval)}
  end

  @spec log_refresh(non_neg_integer | false) :: :ok
  defp log_refresh(ms_left) when is_integer(ms_left) do
    elapsed = @refresh_interval - ms_left
    Log.info(:explicit_refresh, {elapsed, ms_left, __ENV__})
  end

  defp log_refresh(false) do
    Log.info(:automatic_refresh, {@refresh_interval, __ENV__})
  end
end
