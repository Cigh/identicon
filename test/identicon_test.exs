defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "Hash the input" do
    identicon = Identicon.hash_input("test")
    assert identicon.hex == [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
  end

  test "Pick the color" do
    identicon = Identicon.hash_input("test")
    |> Identicon.pick_color()

    assert identicon.color == {9, 143, 107}
  end

  test "Build the grid" do
    identicon = Identicon.hash_input("test")
    |> Identicon.pick_color()
    |> Identicon.build_grid()

    assert identicon.grid == [
      {9, 0},
      {143, 1},
      {107, 2},
      {143, 3},
      {9, 4},
      {205, 5},
      {70, 6},
      {33, 7},
      {70, 8},
      {205, 9},
      {211, 10},
      {115, 11},
      {202, 12},
      {115, 13},
      {211, 14},
      {222, 15},
      {78, 16},
      {131, 17},
      {78, 18},
      {222, 19},
      {38, 20},
      {39, 21},
      {180, 22},
      {39, 23},
      {38, 24} 
    ]
  end

  test "Filter out odd squares" do
    identicon = Identicon.hash_input("test")
      |> Identicon.pick_color()
      |> Identicon.build_grid()
      |> Identicon.filter_odd_squares()

      assert identicon.grid == [
        {70, 6},
        {70, 8},
        {202, 12},
        {222, 15},
        {78, 16},
        {78, 18},
        {222, 19},
        {38, 20},
        {180, 22},
        {38, 24}
      ]
  end

  test "Build the pixel map" do
    identicon = Identicon.hash_input("test")
      |> Identicon.pick_color()
      |> Identicon.build_grid()
      |> Identicon.filter_odd_squares()
      |> Identicon.build_pixel_map()

    assert identicon.pixel_map == [
      {{50, 50}, {100, 100}},
      {{150, 50}, {200, 100}},
      {{100, 100}, {150, 150}},
      {{0, 150}, {50, 200}},
      {{50, 150}, {100, 200}},
      {{150, 150}, {200, 200}},
      {{200, 150}, {250, 200}},
      {{0, 200}, {50, 250}},
      {{100, 200}, {150, 250}},
      {{200, 200}, {250, 250}}
    ]      
  end
end
