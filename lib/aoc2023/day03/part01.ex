defmodule Aoc2023.Day03.Part01 do
  import Util

  @num_regex ~r/\d+/
  @symbol_regex ~r/[^\w\.]/

  def solve() do
    read_input("./day03_input.txt")
    |> Enum.map(&String.trim/1)
    |> solve
  end

  def solve(input) do
    input
    |> get_all_part_nums()
    |> Enum.sum()
  end

  def get_num_coords(line, index) do
    Regex.scan(@num_regex, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {i, len} -> to_num_tuple(i, index, len, line) end)
  end

  def get_symbol_coords(line, index) do
    Regex.scan(@symbol_regex, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {i, _len} -> {i, index} end)
  end
  
  def get_all_num_coords(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, i} -> get_num_coords(line, i) end)
  end

  def get_all_symbol_coords(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, i} -> get_symbol_coords(line, i) end)
  end

  def is_part_num?(num_tuple, symbol_tuples) do
    adj_spaces = get_adj_spaces(num_tuple)
    Enum.any?(adj_spaces, fn space -> Enum.member?(symbol_tuples, space) end)
  end

  def get_all_part_nums(input) do
    symbol_coords = get_all_symbol_coords(input)
    num_coords = get_all_num_coords(input)

    Enum.filter(num_coords, fn x -> is_part_num?(x, symbol_coords) end)
    |> Enum.map(fn x -> elem(x, 3) end)
  end

  defp get_adj_spaces(num_tuple) do
    start_x = elem(num_tuple, 0)
    end_x = start_x + elem(num_tuple, 2) - 1 # adjust for 0-indexing
    y = elem(num_tuple, 1)

    # gotta be some ranges magic I can do here as an exercise later?
    spaces = [
      {start_x - 1, y},
      {end_x + 1, y},
      {start_x - 1, y - 1},
      {end_x + 1, y + 1},
      {start_x - 1, y + 1},
      {end_x + 1, y - 1}
    ]

    spaces = Enum.map(start_x..end_x//1, fn x -> {x, y - 1} end) ++ spaces
    Enum.map(start_x..end_x//1, fn x -> {x, y + 1} end) ++ spaces
  end

  defp to_num_tuple(x_coord, y_coord, length, line) do
    num = 
      line
      |> String.slice(x_coord, length)
      |> String.to_integer()

    {x_coord, y_coord, length, num}
  end
end
