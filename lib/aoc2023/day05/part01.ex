defmodule Aoc2023.Day05.Part01 do
  import Util
  alias Aoc2023.Day05.CategoryMap
  alias Aoc2023.Day05.Mapping

  def solve do
    read_input("./day05_input.txt")
    |> solve()
  end

  def solve(input) do
    [["seeds: " <> seed_str] | category_maps] =
      input
      |> Stream.chunk_by(&is_not_empty_string/1)
      |> Stream.reject(&is_empty_string_list/1)
      |> Enum.to_list()

    seeds =
      seed_str
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

    category_maps = 
      category_maps
      |> Enum.map(&parse_category_map/1)

    seeds
    |> Enum.map(fn x -> get_location(x, category_maps) end)
    |> Enum.min()
  end

  def get_location(input, [map | maps]) do
    mapping =
      map.mappings
      |> Enum.find(fn x -> Enum.member?(x.src_range, input) end)

    output = case mapping do
      %Mapping{} -> input - mapping.src_range.first + mapping.dest_offset
      _ -> input
    end

    get_location(output, maps)
  end

  def get_location(input, []) do
    input
  end

  def parse_category_map(input) do
    [name | mappings] = input
    %CategoryMap{
      category: name,
      mappings: Enum.map(mappings, fn x -> to_mapping(x) end)
    }
  end

  defp is_not_empty_string(x) do
    String.trim(x)
    |> String.length() > 0
  end

  defp to_mapping(str) do
    [dest, src, length] =
      str
      |> String.split(" ")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)

    %Mapping{
      src_range: src..(src + length),
      dest_offset: dest
    }
  end

  defp is_empty_string_list(x) do
    case x do
      ["\n"] -> true
      _ -> false
    end
  end
end
