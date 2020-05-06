defmodule Helloworld do
  @moduledoc """
  Documentation for `Helloworld`.
  """

  @doc """
  Shows Hello World in the shell.

  ## Examples
      iex> Helloworld.hello()
      "Hello World"
  """
  def hello do
    "Hello World"
  end

  @doc """
  Says hello to the given "name".

  ## Parameters
  - name: String that represents the name of the person.

  ## Examples
      iex> Helloworld.hello("Oriana")
      "Hello Oriana"
  """
  def hello(name) do
    "Hello #{name}"
  end
end
