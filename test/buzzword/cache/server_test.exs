defmodule Buzzword.Cache.ServerTest do
  use ExUnit.Case, async: true

  alias Buzzword.Cache.Server

  doctest Server

  describe "Server.start_link/1" do
    test "returns a tuple" do
      assert {:error, {:already_started, pid}} = Server.start_link(:ok)
      assert is_pid(pid) and pid == Process.whereis(Server)
    end
  end
end
