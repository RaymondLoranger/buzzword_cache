defmodule Buzzword.Cache.IE do
  @moduledoc false

  # Example of an IEx session...
  #
  #   iex -S mix
  #
  #   use Buzzword.Cache.IE
  #   Cache.get_buzzwords
  #   => change assets/buzzwords.csv
  #   Cache.refresh
  #   Cache.get_buzzwords
  #   => see that the change is reflected
  #   => change back assets/buzzwords.csv

  defmacro __using__(_options) do
    quote do
      alias unquote(__MODULE__)

      alias Buzzword.Cache.{
        App,
        Loader,
        Log,
        Server
      }

      alias Buzzword.Cache
      :ok
    end
  end
end
