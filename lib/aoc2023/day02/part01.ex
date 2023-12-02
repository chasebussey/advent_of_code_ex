defmodule Aoc2023.Day02.Part01 do
  import Util

  @cubes %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def solve() do
    read_input("./day02_input.txt")
    |> Enum.reduce(0, fn x, acc -> get_game_data(x) + acc end)
  end
  
  def solve(input) do
    Enum.reduce(input, 0, fn x, acc -> get_game_data(x) + acc end)
  end
  
  def get_game_data(line) do
    elems = 
      line
      |> String.trim()
      |> String.split(":")

    game_id = get_game_id(hd(elems))

    color_strings = String.split(List.last(elems), ";")
    possible = game_is_possible?(color_strings)
    
    if possible do
      game_id
    else
      0
    end
  end
  
  def get_game_id(game_str) do
    String.split(game_str," ")
    |> List.last()
    |> String.to_integer()
  end
  
  def game_is_possible?(color_strings) do
    color_strings
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, ",") end)
    |> Enum.all?(fn x -> is_possible?(x) end)
  end

  # color_str is a list of individual color strings
  def is_possible?(color_str_list) do
    color_str_list
    |> Enum.all?(&color_is_possible?/1)
  end

  def color_is_possible?(color_str) do
    color = 
      color_str
      |> String.trim
      |> String.split(" ")
      |> List.to_tuple()
    is_possible?(elem(color, 0), elem(color, 1))
  end

  def is_possible?(number, color) do
    number = String.to_integer(number)
    number <= @cubes[color]
  end
end
