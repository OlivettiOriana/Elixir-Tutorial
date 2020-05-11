defmodule Truco do
  alias Truco.Deck
  alias Truco.Player
  alias Truco.Card

  def start_game do
    IO.puts("Bienvenido a Truco!")
    name = IO.gets("Cual es tu nombre? ")
          |> String.replace("\n", "")

    Deck.create_deck()
    |> Deck.shuffle()
    |> Deck.deal(name)
    |> play_hand()
  end

  def play_hand([%Player{cards: [], score: score_1, name: name1}, %Player{cards: [], score: score_2, name: name2}]) do

    IO.inspect score_1
    IO.inspect score_2
    cond do
      score_1 > score_2 -> "#{name1} eres el Ganador de la mano!"
      score_1 < score_2 -> "#{name2} eres el Ganador de la mano!"
      true -> "#{name1} y #{name2} han empatado la mano!"
    end
  end

  def play_hand(list_players) do
    list_players
    |> choose
    |> compare
    |> win_or_loose
    |> check
  end

  def choose([%Player{cards: cards1, name: name1} = player1, %Player{cards: cards2, name: name2} = player2]) do
    IO.puts("Estas son tus cartas #{name1}")
    Enum.with_index(cards1)
    |> Enum.map(fn {%Card{name: name}, index} -> IO.puts("#{index + 1}) #{name}") end)

    IO.puts("Que carta quieres elegir? (1, 2 o 3)")
    {card_index_1, _} = IO.gets("Elegiste el numero: ")
                  |> Integer.parse()

    card1 = Enum.at(cards1, card_index_1 - 1)
    card2 = Enum.random(cards2)

    IO.puts("Tu carta: #{card1.name}")
    IO.puts("La carta de tu oponente #{name2}: #{card2.name}")

    [
      %Player{player1 | selected_card: card1},
      %Player{player2 | selected_card: card2}
    ]
  end

  def compare([
        %Player{selected_card: %Card{magic: magic1}} = player1,
        %Player{selected_card: %Card{magic: magic2}} = player2]) do
    cond do
      magic1 > magic2 -> {:win, [player1, player2]}
      magic1 < magic2 -> {:loose, [player1, player2]}
      true -> {:tie, [player1, player2]}
    end
  end

  def win_or_loose(
    {status, [%Player{score: score1, name: name1} = player1, %Player{score: score2, name: name2} = player2]}) do
    case status do
      :win ->
        IO.puts("Ganaste la mano #{name1}!")
        [%Player{player1 | score: score1 + 1}, player2]

      :loose ->
        IO.puts("Perdiste la mano #{name1}!")
        [player1, %Player{player2 | score: score2 + 1}]

      :tie ->
        IO.puts("Empate #{name1} y #{name2}!")
        [player1, player2]
    end
  end

  def check([%Player{cards: cards1, selected_card: %Card{name: card1}} = player1,
            %Player{cards: cards2, selected_card: %Card{name: card2}} = player2]) do

    remained_cards1 = Enum.filter(cards1,fn %Card{name: card_name1} -> card_name1 != card1 end)
    remained_cards2 = Enum.filter(cards2,fn %Card{name: card_name2} -> card_name2 != card2 end)

    play_hand([%Player{player1 | cards: remained_cards1, selected_card: nil},
              %Player{player2 | cards: remained_cards2, selected_card: nil}])
  end

end
