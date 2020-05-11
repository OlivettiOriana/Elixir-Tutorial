defmodule Identicon do

  defmodule Identicon.Image do
    defstruct bin: nil,
              color: nil,
              grid: nil,
              pixel_map: nil
  end
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def create(name) do
    hash_input(name)
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(name)

  end

  def hash_input(input) do
    bin = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{bin: bin}
  end

  def pick_color(%Identicon.Image{bin: [ r, g, b | _tail]} = image) do
    %Identicon.Image{ image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{bin: bin} = image) do
    grid = Enum.chunk_every(bin,3)
      |> Enum.drop(-1)
      |> Enum.map(&mirror_row/1)
      |> Enum.concat
      |> Enum.with_index
    %Identicon.Image{ image | grid: grid}
  end

  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn { code, _index } ->
      rem(code, 2) == 0
    end

    %Identicon.Image{ image | grid: grid }
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({ _code, index }) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = { horizontal, vertical }
      bottom_right = { horizontal + 50, vertical + 50}
      { top_left, bottom_right }
    end

    %Identicon.Image{ image | pixel_map: pixel_map }
  end

  def draw_image(%Identicon.Image{ color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each pixel_map, fn({ start, stop }) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

end
