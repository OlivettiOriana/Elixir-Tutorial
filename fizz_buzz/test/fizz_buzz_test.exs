defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "testing FizzBuzz" do
    assert FizzBuzz.fuzzle(0, 0, 4) == "FizzBuzz"
  end
  test "testing Fizz" do
    assert FizzBuzz.fuzzle(0, 3, 5) == "Fizz"
  end
  test "testing Buzz" do
    assert FizzBuzz.fuzzle(9, 0, 8) == "Buzz"
  end
  test "testing 3rd argument" do
    assert FizzBuzz.fuzzle(9, 4, 8) == 8
  end
end
