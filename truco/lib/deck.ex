defmodule Truco.Deck do
  alias Truco.Card
  alias Truco.Player

  def create_deck do
    [
      %Card{name: "1 de Espada", magic: 13},
      %Card{name: "2 de Espada", magic: 8},
      %Card{name: "3 de Espada", magic: 9},
      %Card{name: "4 de Espada", magic: 0},
      %Card{name: "5 de Espada", magic: 1},
      %Card{name: "6 de Espada", magic: 2},
      %Card{name: "7 de Espada", magic: 11},
      %Card{name: "10 de Espada", magic: 4},
      %Card{name: "11 de Espada", magic: 5},
      %Card{name: "12 de Espada", magic: 6},
      %Card{name: "1 de Copa", magic: 7},
      %Card{name: "2 de Copa", magic: 8},
      %Card{name: "3 de Copa", magic: 9},
      %Card{name: "4 de Copa", magic: 0},
      %Card{name: "5 de Copa", magic: 1},
      %Card{name: "6 de Copa", magic: 2},
      %Card{name: "7 de Copa", magic: 3},
      %Card{name: "10 de Copa", magic: 4},
      %Card{name: "11 de Copa", magic: 5},
      %Card{name: "12 de Copa", magic: 6},
      %Card{name: "1 de Oro", magic: 7},
      %Card{name: "2 de Oro", magic: 8},
      %Card{name: "3 de Oro", magic: 9},
      %Card{name: "4 de Oro", magic: 0},
      %Card{name: "5 de Oro", magic: 1},
      %Card{name: "6 de Oro", magic: 2},
      %Card{name: "7 de Oro", magic: 10},
      %Card{name: "10 de Oro", magic: 4},
      %Card{name: "11 de Oro", magic: 5},
      %Card{name: "12 de Oro", magic: 6},
      %Card{name: "1 de Palo", magic: 12},
      %Card{name: "2 de Palo", magic: 8},
      %Card{name: "3 de Palo", magic: 9},
      %Card{name: "4 de Palo", magic: 0},
      %Card{name: "5 de Palo", magic: 1},
      %Card{name: "6 de Palo", magic: 2},
      %Card{name: "7 de Palo", magic: 3},
      %Card{name: "10 de Palo", magic: 4},
      %Card{name: "11 de Palo", magic: 5},
      %Card{name: "12 de Palo", magic: 6}
    ]
  end

  def shuffle(deck), do: Enum.shuffle(deck)

  def deal(deck, player_name) do
    [hand1, hand2 | _res] = Enum.chunk(deck, 3)
    [%Player{cards: hand1, name: player_name}, %Player{cards: hand2, name: "Machine"}]
  end
end
