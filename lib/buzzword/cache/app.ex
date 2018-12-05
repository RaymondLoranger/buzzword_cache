defmodule Buzzword.Cache.App do
  @moduledoc false

  use Application
  use PersistConfig

  alias __MODULE__
  alias __MODULE__.LogReset
  alias Buzzword.Cache.Server

  @info_path Application.get_env(:logger, :info_log)[:path]
  @warn_path Application.get_env(:logger, :warn_log)[:path]

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    unless Mix.env() == :test do
      [@info_path, @warn_path] |> Enum.each(&LogReset.clear_log/1)
    end

    [
      # Child spec relying on use GenServer...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: App, strategy: :one_for_one)
  end
end
