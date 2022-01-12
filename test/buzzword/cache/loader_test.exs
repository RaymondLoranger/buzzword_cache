defmodule Buzzword.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache.Loader

  defguard is_buzzword(term)
           when is_tuple(term) and is_binary(elem(term, 0)) and
                  is_integer(elem(term, 1))

  doctest Loader

  describe "Loader.read_buzzwords/0" do
    test "returns a map of buzzwords from the CSV file" do
      buzzwords = Loader.read_buzzwords()
      assert is_map(buzzwords)
      assert Enum.all?(buzzwords, &is_buzzword/1)
    end
  end
end
