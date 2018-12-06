defmodule Buzzword.Cache.App do
  @moduledoc false

  use Application

  alias __MODULE__
  alias Buzzword.Cache.Server
  alias Log.Reset

  @info_path Application.get_env(:logger, :info_log)[:path]
  @warn_path Application.get_env(:logger, :warn_log)[:path]

  @spec start(Application.start_type(), term) :: {:ok, pid}
  def start(_type, :ok) do
    unless Mix.env() == :test do
      [@info_path, @warn_path] |> Enum.each(&Reset.clear_log/1)
    end

    [
      # Child spec relying on use GenServer...
      {Server, :ok}
    ]
    |> Supervisor.start_link(name: App, strategy: :one_for_one)
  end
end
