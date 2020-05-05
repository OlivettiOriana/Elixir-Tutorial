defmodule HelloworldTest do
  use ExUnit.Case
  doctest Helloworld

  test "greets the world" do
    assert Helloworld.hello() == "Hello World"
  end

  test "greets someone" do
    assert Helloworld.hello("Lucas") == "Hello Lucas"
  end
end
