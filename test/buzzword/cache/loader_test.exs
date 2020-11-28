defmodule Buzzword.Cache.LoaderTest.Env do
  def disable_log do
    log? = Application.get_env(:file_only_logger, :log?)
    Application.put_env(:file_only_logger, :log?, false)
    log?
  end

  def restore_log(log?) do
    case log? do
      nil -> Application.delete_env(:file_only_logger, :log?)
      _ -> Application.put_env(:file_only_logger, :log?, log?)
    end
  end
end

defmodule Buzzword.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache.LoaderTest.Env
  alias Buzzword.Cache.Loader

  doctest Loader

  describe "Loader.read_buzzwords/0" do
    test "returns a map" do
      log? = Env.disable_log()
      buzzwords = Loader.read_buzzwords()
      :ok = Env.restore_log(log?)
      assert is_map(buzzwords)

      assert Enum.all?(buzzwords, fn {phrase, points} ->
               is_binary(phrase) and is_integer(points)
             end)
    end
  end
end
