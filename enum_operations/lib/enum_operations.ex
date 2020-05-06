defmodule EnumOperations do
  @moduledoc """
  Documentation for `EnumOperations`.
  """

  @doc """
  Returns how many elements there are in a list.

  ## Parameters

  - a_list: the list you need to know how many items it has.
  - an_integer (optional): The result will be added to this value.

  ## Examples

      iex> EnumOperations.count([])
      0

      iex> EnumOperations.count([1, 2, 3, 4])
      4

  """
  def count(a_list, an_integer \\ 0)
  def count([_head | tail], counter), do: count(tail, counter + 1)
  def count([], counter), do: counter


  @doc """
  Returns the reverse of a given list.

  ## Parameters

  - a_list: the list you need to revert.

  ## Examples

      iex> EnumOperations.reverse([])
      []

      iex> EnumOperations.reverse([1, 2, 3, 4])
      [4,3,2,1]

  """
  def reverse(a_list)
  def reverse(list), do: reverse(list, [])
  defp reverse([head | tail], list), do: reverse(tail, [head | list])
  defp reverse([], list), do: list


  @doc """
  #1. Given two lists, concat/2 will return a single list with all values.

  #2. Given a single nested list, concat/1 will return a flattened list.

  ## Parameters

  - list_or_nested_list: the list you need to concat/flatter.
  - second_list (optional): the other list you want to concat

  ## Examples

      iex> EnumOperations.concat([1,2], [3,4])
      [2,1,3,4]

      iex> EnumOperations.concat([[5], [6,7]])
      [7,6,5]

  """
  def concat(list_or_nested_list, second_list \\ [])
  def concat([head | tail], b) when is_list(head), do: concat(tail, concat(head, b))
  def concat([head | tail], b), do: concat(tail, [head | b])
  def concat([], b), do: b

  @doc """
  Given a list and a function, filter() will return a list which elements returned true when function was applied.

  ## Parameters

  - a_list: List of any type.
  - a_function: The filter to apply.
  - accumulator_list (optional): The elements which returned true when function was applied will be here.

  ## Examples

      iex> EnumOperations.filter([1,2,3,4], & rem(&1,2) == 0)
      [4,2]

      iex> EnumOperations.filter([1,2,3,4], & &1 <3)
      [2,1]

  """
  def filter(a_list, a_function, accumulator_list \\ [])
  def filter([head | tail], function, acc) do
    if function.(head) do
      filter(tail, function, [head|acc])
    else
      filter(tail, function, acc)
    end
  end
  def filter([], _fun, acc), do: acc

end
