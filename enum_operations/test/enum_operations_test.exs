defmodule EnumOperationsTest do
  use ExUnit.Case
  doctest EnumOperations

  test "greets the world" do
    assert EnumOperations.count([]) == 0
    assert EnumOperations.count([1,2,3]) == 3
    assert EnumOperations.count([1,"a","b",3]) == 4
  end
end
