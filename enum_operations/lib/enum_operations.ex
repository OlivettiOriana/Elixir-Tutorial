defmodule EnumOperations do
  @moduledoc """
  Documentation for `EnumOperations`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> EnumOperations.count([])
      0

      iex> EnumOperations.count([1, 2, 3, 4])
      4

  """
  def count(arg1, arg2 \\ 0)

  def count([_head | tail], counter) do
    count(tail, counter + 1)
  end

  def count([], counter) do
    counter
  end

  def reverse(list) do
    reverse(list, [])
  end

  defp reverse([head | tail], list) do
    reverse(tail, [head | list])
  end

  defp reverse([], list) do
    list
  end

  def concat(a, b \\ [])

  def concat([head | tail], b) do
    concat(tail, [head | b])
  end

  def concat([], b) do
    b
  end

end
