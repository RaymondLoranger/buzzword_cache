defmodule Buzzword.Cache.LoaderTest.Env do
  def disable_log do
    level = Application.get_env(:file_only_logger, :level)
    Application.put_env(:file_only_logger, :level, :none)
    level
  end

  def restore_log(level) do
    case level do
      nil -> Application.delete_env(:file_only_logger, :level)
      _ -> Application.put_env(:file_only_logger, :level, level)
    end
  end
end

defmodule Buzzword.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias __MODULE__.Env
  alias Buzzword.Cache.Loader

  doctest Loader

  describe "Loader.read_buzzwords/0" do
    test "returns a map" do
      level = Env.disable_log()
      buzzwords = Loader.read_buzzwords()
      :ok = Env.restore_log(level)
      assert is_map(buzzwords)

      assert Enum.all?(buzzwords, fn {phrase, points} ->
               is_binary(phrase) and is_integer(points)
             end)
    end
  end
end
