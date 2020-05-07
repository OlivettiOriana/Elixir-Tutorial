defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzzConditional

  test "testing FizzBuzz" do
    assert FizzBuzzConditional.fuzzle(0, 0, 4) == "FizzBuzz"
  end

  test "testing Fizz" do
    assert FizzBuzzConditional.fuzzle(0, 3, 5) == "Fizz"
  end

  test "testing Buzz" do
    assert FizzBuzzConditional.fuzzle(9, 0, 8) == "Buzz"
  end

  test "testing 3rd argument" do
    assert FizzBuzzConditional.fuzzle(9, 4, 8) == 8
  end
end
