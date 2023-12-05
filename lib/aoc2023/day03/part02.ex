defmodule Aoc2023.Day03.Part02 do
  import Util

  @num_regex ~r/\d+/
  @symbol_regex ~r/\*/

  def solve() do
    read_input("./day03_input.txt")
    |> Enum.map(&String.trim/1)
    |> solve
  end

  def solve(input) do
    nums = get_all_num_coords(input)
    symbols = get_all_symbol_coords(input)

    symbols
    |> Enum.map(fn x -> get_gear_ratio(x, nums) end)
    |> Enum.sum
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

  def get_adj_nums(symbol_tuple, nums) do
    Enum.filter(nums, fn x -> is_adjacent?(x, symbol_tuple) end)
  end

  def get_gear_ratio(symbol_tuple, nums) do
    adj_nums = get_adj_nums(symbol_tuple, nums)
    
    case length(adj_nums) do
      2 -> get_gear_ratio(adj_nums)
      _ -> 0
    end
  end

  defp get_gear_ratio(nums) do
    elem(hd(nums), 3) * elem(List.last(nums), 3)
  end

  defp is_adjacent?(num_tuple, symbol_tuple) do
    adj_spaces = get_adj_spaces(num_tuple)
    Enum.member?(adj_spaces, symbol_tuple)
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
