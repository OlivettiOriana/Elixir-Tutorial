defmodule FizzBuzz do
  @moduledoc """
  Documentation for `FizzBuzz`.
  """

  @doc """
  FizzBuzz!!.
  Returns different strings depending on the arguments given to the function.

  ## Parameters

  All three arguments must be integers. When one on several of them are 0, something different happens.
  When arg1 and arg2 are not 0, arg3 is returned.

  ## Examples

      iex> FizzBuzz.fuzzle(0, 0, 4)
      "FizzBuzz"

      iex> FizzBuzz.fuzzle(0, 3, 4)
      "Fizz"

      iex> FizzBuzz.fuzzle(2, 0, 4)
      "Buzz"

      iex> FizzBuzz.fuzzle(3, 7, 4)
      4

  """

  def fuzzle(arg1, arg2, arg3)
  def fuzzle(0, 0, _arg3), do: "FizzBuzz"
  def fuzzle(0, _arg2, _arg3), do: "Fizz"
  def fuzzle(_arg1, 0, _arg3), do: "Buzz"
  def fuzzle(_arg1, _arg2, arg3), do: arg3
end
