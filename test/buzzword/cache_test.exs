defmodule Buzzword.CacheTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache

  doctest Cache

  describe "Cache.get_buzzwords/0" do
    test "returns a map" do
      %{
        "Low-Hanging Fruit" => fruit_points,
        "Mission Critical" => mission_points
      } = Cache.get_buzzwords()

      assert {fruit_points, mission_points} == {300, 225}
    end
  end
end
