defmodule EnumOperationsTest do
  use ExUnit.Case
  doctest EnumOperations



  test "testing count() with empty list" do
    assert EnumOperations.count([]) == 0
  end

  test "testing count() with list of different objects" do
    case_test = [1,"a","b",3]
    assert EnumOperations.count(case_test) == 4
  end

  test "testing count() with list of integers" do
    case_test = [1,2,3]
    assert EnumOperations.count(case_test) == 3
  end


  test "testing reverse() with empty list" do
    assert EnumOperations.reverse([]) == []
  end

  test "testing reverse() with list of different objects" do
    case_test = [1,"a","b",3]
    assert EnumOperations.reverse(case_test) == [3,"b","a",1]
  end

  test "testing reverse() with list of integers" do
    case_test = [1,2,3]
    assert EnumOperations.reverse(case_test) == [3,2,1]
  end

  test "testing reverse() with a nested list" do
    case_test = [[5], [6,7]]
    assert EnumOperations.reverse(case_test) == [[6,7],[5]]
  end

end
