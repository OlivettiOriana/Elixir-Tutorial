defmodule WordCount do
  @moduledoc """
  Documentation for `WordCount`.
  """

  @doc """
  Given a sentence or a paragraph, the function will return how many times each different word appeared as map.

  ## Parameters
  - a_sentence: A string of any kind.

  ## Examples

      iex> WordCount.word_count("")
      %{}

      iex> WordCount.word_count("Hola todo bien, Hola todo bien")
      %{"bien" => 2, "hola" => 2, "todo" => 2}

  """
  def word_count(a_sentence)
  def word_count(sentence) do
    String.downcase(sentence)
    |> String.replace(~r/@|#|\$|%|&|\^|:|_|!|\.|,/u, " ")
    |> String.split()
    |> word_count(%{})
  end
  defp word_count([head | tail], map) do
    map = Map.update(map, head, 1, &(&1 + 1))
    word_count(tail, map)
  end
  defp word_count([], map), do: map
end
