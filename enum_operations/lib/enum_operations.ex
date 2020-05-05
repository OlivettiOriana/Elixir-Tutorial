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

  def concat([head | tail], b) when is_list(head) do
    concat(tail, concat(head, b))
  end

  def concat([head | tail], b) do
    concat(tail, [head | b])
  end

  def concat([], b) do
    b
  end

  # def filter_list([head | tail], fun, acc \\ []) do
  #   if fun.(head) do
  #     filter_list(tail, fun, [head|acc])
  #   else
  #     filter_list(tail, fun, acc)
  #   end
  # end

  def filter([head | tail], function, acc \\ []) do
    if function.(head) do
      filter(tail, function, [head|acc])
    else
      filter(tail, function, acc)
    end
  end

  def filter([], _fun, acc) do
    acc
  end

end
