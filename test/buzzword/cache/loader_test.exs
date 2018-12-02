defmodule Buzzword.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache.Loader

  doctest Loader

  describe "Loader.read_buzzwords/0" do
    test "returns a map" do
      buzzwords = Loader.read_buzzwords()
      assert is_map(buzzwords)

      assert Enum.all?(buzzwords, fn {buzzword, points} ->
               is_binary(buzzword) and is_integer(points)
             end)
    end
  end
end
