defmodule Buzzword.Cache.LoaderTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache.Loader

  # Assuming only ASCII characters...
  defguard is_buzzword(term)
           when is_tuple(term) and elem(term, 0) |> is_binary() and
                  elem(term, 0) |> byte_size() >= 3 and
                  elem(term, 1) |> is_integer() and elem(term, 1) > 0

  doctest Loader

  describe "Loader.read_buzzwords/0" do
    test "returns a map of buzzwords from the CSV file" do
      buzzwords = Loader.read_buzzwords()
      assert is_map(buzzwords)
      assert Enum.all?(buzzwords, &is_buzzword/1)
    end
  end
end
