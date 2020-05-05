defmodule Helloworld do
  @moduledoc """
  Documentation for `Helloworld`.
  """

  @doc """
  There are two functions..
  #1. Helloworld.hello/0
    Shows Hello World in the shell.
      iex> Helloworld.hello()
      "Hello World"

  #2. Helloworld.hello/1
    Says hello to the given "name".

      iex> Helloworld.hello("Oriana")
      "Hello Oriana"

  ## Examples

      iex> Helloworld.hello()
      "Hello World"

  """
  def hello do
    "Hello World"
  end

  def hello(name) do
    "Hello #{name}"
  end
end
