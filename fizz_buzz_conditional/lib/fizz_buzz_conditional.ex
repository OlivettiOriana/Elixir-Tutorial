defmodule FizzBuzzConditional do
  @moduledoc """
  Documentation for `FizzBuzzConditional`.
  """

  @doc """
  FizzBuzz!!.
  Returns different strings depending on the arguments given to the function.

  ## Parameters
  All three arguments must be integers. When one on several of them are 0, something different happens.
  When arg1 and arg2 are not 0, arg3 is returned.

  ## Examples

      iex> FizzBuzzConditional.fuzzle_case(0, 0, 4)
      "FizzBuzz"

      iex> FizzBuzzConditional.fuzzle_case(0, 3, 4)
      "Fizz"

      iex> FizzBuzzConditional.fuzzle_cond(2, 0, 4)
      "Buzz"

      iex> FizzBuzzConditional.fuzzle_cond(3, 7, 4)
      4

  """

  def fuzzle_case(arg1, arg2, arg3) do
    case {arg1, arg2, arg3} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, arg3} -> arg3
    end
  end

  def fuzzle_cond(arg1, arg2, arg3) do
    cond do
      arg1 == 0 and arg2 == 0 -> "FizzBuzz"
      arg1 == 0 -> "Fizz"
      arg2 == 0 -> "Buzz"
      true -> arg3
    end
  end
end
