defmodule CardGame do
  @moduledoc """
  Documentation for `CardGame`.

  It's a War Card Game. The highest point wins the round!
  """

  @doc """
  You just need to type..
      CardGame.start()

  Fist, a deck is created and shuffled.
  Then, the players are added and the hands are dealed.
  Finally, the game starts!
  """
  def start() do
    deck = create_deck()
    |> shuffle()

    {_deck, players} = create_players_list()
                      |> add_player("Mark")
                      |> deal(deck)

    play_round(players)
  end

  @doc """
  Creates a deck to play.

  ## Examples

      iex> CardGame.create_deck()
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
      "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
      "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
      "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
      "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

  """
  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles the given deck.

  """
  def shuffle(deck), do: Enum.shuffle(deck)


  @doc """
  Given a hand size, takes it from the deck and returns a Tuple with the hand for the player and the remaining deck.

  ## Examples

      iex> CardGame.get_hand([1,2,3,4,5], 3)
      {[1,2,3], [4,5]}

  """
  def get_hand(deck, hand_size), do: Enum.split(deck, hand_size)


  @doc """
  Given a list of players and a name, the player is inicialized.

  ## Examples

      iex> CardGame.add_player([%{"name" => "Oriana", "points" => 50, "hand" => []}], "Mark")
      [%{"hand" => [], "name" => "Oriana", "points" => 50},
      %{"hand" => [], "name" => "Mark", "points" => 50}]

  """
  def add_player(players, name), do: players ++ [%{"name" => name, "points" => 50, "hand" => []}]


  @doc """
  Creates the list of players for the first time.

  ## Examples

      iex> CardGame.create_players_list()
      [%{"hand" => [], "name" => "Oriana", "points" => 50}]

  """
  def create_players_list(), do: add_player([], "Oriana")

  @doc """
  Given a name and the list of players, it will return the player's info.

  ## Examples

      iex> CardGame.get_player([%{"hand" => [], "name" => "Oriana", "points" => 50}], "Oriana")
      {:ok, %{"hand" => [], "name" => "Oriana", "points" => 50}}

      iex> CardGame.get_player([%{"hand" => [], "name" => "Oriana", "points" => 50}], "Mark")
      {:error, "The player Mark was not found"}
  """
  def get_player([], name), do: {:error, "The player #{name} was not found"}
  def get_player([player | players], name) do
    if player["name"] == name, do: {:ok, player},
      else: get_player(players, name)
  end

  @doc """
  Given a list of players and the deck, the hands will be dealed to each of them.
  The deck is returned without the dealed cards.

  ## Examples

      iex> CardGame.deal([%{"hand" => [], "name" => "Oriana", "points" => 50}], [1,2,3,4,5,6,7,8,9,10])
      {[6, 7, 8, 9, 10], [%{"hand" => [1, 2, 3, 4, 5], "name" => "Oriana", "points" => 50}]}

  """
  def deal([], deck), do: {deck, []}
  def deal([player | players], deck) do
    {hand, deck} = get_hand(deck, 5)
    player = Map.update(player, "hand", [], &(&1 ++ hand))
    {deck, players} = deal(players, deck)
    {deck, players ++ [player]}
  end

  @doc """
  Given only two players, the rounds start until players no longer have cards.

  """
  def play_round([%{"hand" => [], "points" => points1, "name" => name1},
                %{"hand" => [], "points" => points2, "name" => name2}]) do
    IO.puts "Termino el juego!"
    IO.puts "Los puntos de #{name1} son: #{points1}"
    IO.puts "Los puntos de #{name2} son: #{points2}"

    cond do
      points1 > points2 -> IO.puts "El ganador es #{name1}!"
      points1 < points2 -> IO.puts "El ganador es #{name2}!"
      true -> IO.puts "Empate. Todos son ganadores!"
    end
  end

  def play_round([%{"hand" => hand1, "points" => points1} = player1,
                  %{"hand" => hand2, "points" => points2} = player2]) do

    [card1 | hand1] = hand1
    [card2 | hand2] = hand2

    IO.puts "Carta jugada por #{player1["name"]}: #{card1}"
    IO.puts "Carta jugada por #{player2["name"]}: #{card2}"

    player1 = Map.put(player1, "hand", hand1)
    player2 = Map.put(player2, "hand", hand2)

    cond do
      card1 > card2 ->
        IO.puts "Gano #{player1["name"]} la mano"
        play_round([%{player1 | "points" => points1 + 1}, %{player2 | "points" => points2 - 1}])

      card1 < card2 ->
        IO.puts "Gano #{player2["name"]} la mano"
        play_round([%{player1 | "points" => points1 - 1}, %{player2 | "points" => points2 + 1}])

      true ->
        IO.puts "Empate de mano."
        play_round([player1, player2])
    end

  end

end
