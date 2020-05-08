defmodule CardGame do
  @moduledoc """
  Documentation for `CardGame`.
  """

  @doc """
  Hello world.

  ## Examples


  """

  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck), do: Enum.shuffle(deck)


  @doc """
  Given a hand size, takes it from the deck and returns a Tuple with the hand for the player and the remaining deck.

  ## Examples

      iex> CardGame.get_hand([1,2,3,4,5], 3)
      {[1,2,3], [4,5]}

  """
  def get_hand(deck, hand_size), do: Enum.split(deck, hand_size)

  def add_player(players, name), do: players ++ [%{"name" => name, "points" => 50, "hand" => []}]

  def create_players_list(), do: add_player([], "Oriana")

  def get_player([], name), do: {:error, "The player #{name} was not found"}
  def get_player([player | players], name) do
    if player["name"] == name, do: {:ok, player},
      else: get_player(players, name)
  end

  def deal([], deck), do: {deck, []}
  def deal([player | players], deck) do
    {hand, deck} = get_hand(deck, 5)
    player = Map.update(player, "hand", [], &(&1 ++ hand))
    {deck, players} = deal(players, deck)
    {deck, players ++ [player]}
  end

  # #only two players per round
  # def play_round(players) do
  #   {player1 | player2} = players
  #   for hand1 <- player1["hand"], hand2 <- player2["hand"] do
  #     if hand1 > hand2 do
  #       player1["points"] = player1["points"] + 1
  #       player2["points"] = player2["points"] - 1
  #     else
  #       player2["points"] = player2["points"] + 1
  #       player1["points"] = player1["points"] - 1
  #     end
  #   end
  # end

end
