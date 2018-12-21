defmodule Buzzword.Cache.App do
  @moduledoc false

  use Application
  use PersistConfig

  alias __MODULE__
  alias Buzzword.Cache.Server

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    [
      # Child spec relying on use GenServer...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: App, strategy: :one_for_one)
  end

  @spec log? :: boolean
  def log?, do: Application.get_env(@app, :log?) || false
end
