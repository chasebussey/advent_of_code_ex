defmodule Aoc2023.Day02.Part02 do
  import Util

  def solve() do
    read_input("./day02_input.txt")
    |> Enum.reduce(0, fn x, acc -> get_power_of_game(x) + acc end)
  end

  def solve(input) do
    Enum.reduce(input, 0, fn x, acc -> get_power_of_game(x) + acc end)
  end
  
  def get_power_of_game(game) do
    color_strs = 
      game
      |> String.split(":")
      |> List.last()
      |> String.trim()
      |> String.split(";")

    min_red =
      color_strs
      |> Enum.reduce(0, fn x, acc -> set_min_val(x, acc, "red") end)
    min_blue =
      color_strs
      |> Enum.reduce(0, fn x, acc -> set_min_val(x, acc, "blue") end)
    min_green =
      color_strs
      |> Enum.reduce(0, fn x, acc -> set_min_val(x, acc, "green") end)

    min_red * min_blue * min_green
  end

  def set_min_val(str, x, color) do
    ind_colors = 
      str
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      
    val = case Enum.filter(ind_colors, fn x -> String.contains?(x, color) end) do
      [] -> x
      [str] -> 
        str
        |> String.trim()
        |> String.split(" ")
        |> hd
        |> String.to_integer()
    end

    if val > x do
      val
    else
      x
    end
  end
end
