defmodule EnumOperations do
  @moduledoc """
  Documentation for `EnumOperations`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> EnumOperations.count([])
      0

  """
  def count(arg1, arg2 \\ 0)

  def count([_head | tail], counter) do
    count(tail, counter + 1)
  end

  def count([], counter) do
    counter 
  end


end
