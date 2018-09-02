defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    filtered_grid = 
      Enum.filter grid, fn({value, _index}) ->
        rem(value, 2) == 0
      end

    %Identicon.Image{image | grid: filtered_grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second, _p] = row

    row ++ [second, first]    
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    
    %Identicon.Image{image | color: {r, g, b}}
  end
  
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
          |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
