defmodule WordCountTest do
  use ExUnit.Case
  doctest WordCount

  test "testing counter with empty strings" do
    assert WordCount.word_count("") == %{}
  end
  test "testing counter with uppecarse and punctuation" do
    assert WordCount.word_count("HOLA, mundo. Chau, mundo!") == %{"hola" => 1, "mundo" => 2, "chau" => 1}
  end
  test "testing counter with numbers" do
    assert WordCount.word_count("1 uno, 2 dos, 3 tres") == %{"1" => 1, "uno" => 1, "2" => 1, "dos" => 1, "3" => 1, "tres" => 1}
  end
end
