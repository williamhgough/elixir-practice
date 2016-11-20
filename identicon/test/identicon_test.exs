defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input returns same value" do
    first = Identicon.hash_input("asdf")
    second = Identicon.hash_input("asdf")
    assert first == second
  end
  
end
