defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzzConditional

  test "testing FizzBuzz" do
    assert FizzBuzzConditional.fuzzle_case(0, 0, 4) == "FizzBuzz"
    assert FizzBuzzConditional.fuzzle_cond(0, 0, 4) == "FizzBuzz"
  end

  test "testing Fizz" do
    assert FizzBuzzConditional.fuzzle_case(0, 3, 5) == "Fizz"
    assert FizzBuzzConditional.fuzzle_cond(0, 3, 5) == "Fizz"
  end

  test "testing Buzz" do
    assert FizzBuzzConditional.fuzzle_case(9, 0, 8) == "Buzz"
    assert FizzBuzzConditional.fuzzle_cond(9, 0, 8) == "Buzz"
  end

  test "testing 3rd argument" do
    assert FizzBuzzConditional.fuzzle_case(9, 4, 8) == 8
    assert FizzBuzzConditional.fuzzle_cond(9, 4, 8) == 8
  end
end
