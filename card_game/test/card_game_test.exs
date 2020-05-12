defmodule CardGameTest do
  use ExUnit.Case
  doctest CardGame

  test "testing deck creation" do
    assert length(CardGame.create_deck()) == 20
  end

  test "testing deck's shuffle" do
    deck = CardGame.create_deck()
    refute CardGame.shuffle(deck) == deck
  end

  test "testing players creation" do
    assert length(CardGame.create_players_list()) == 1
  end

  test "testing adding a player" do
    CardGame.create_players_list()
    |> CardGame.add_player("Mark")
    |> length()
    |> case do
      2 -> assert true
      _ -> assert false
    end
  end

  test "testing players's existance" do
    CardGame.create_players_list()
    |> CardGame.add_player("Mark")
    |> CardGame.get_player("Mark")
    |> case do
        {:ok, _} -> assert true
        {:error,_} -> assert false
    end
  end

  test "testing deal between players" do
    deck = CardGame.create_deck()
    {new_deck, players} = CardGame.create_players_list()
    |> CardGame.add_player("Mark")
    |> CardGame.deal(deck)

    refute new_deck == deck
    for player <- players do
      assert length(player["hand"]) != 0
    end
  end

end
