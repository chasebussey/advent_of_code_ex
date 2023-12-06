defmodule Aoc2023.Day05.Part02 do
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
      |> to_seed_ranges()

    category_maps = 
      category_maps
      |> Enum.map(&parse_category_map/1)
      |> Enum.reverse()

    0..99_999_999_999
    |> Enum.reduce_while(0, fn x, acc -> get_min_location(x, acc, category_maps, seeds) end)
  end

  def to_seed_ranges(seed_list) do
    seed_list
    |> Enum.chunk_every(2)
    |> Enum.map(&to_seed_range/1)
  end

  def to_seed_range([start, length]) do
    start..(start + length)
  end

  def get_min_location(x, _acc, category_maps, seeds) do
    seed = get_location(x, category_maps)
    if is_seed(seed, seeds) do
      {:halt, x}
    else
      {:cont, 0}
    end
  end

  def is_seed(x, seeds) do
    Enum.any?(seeds, fn y -> Enum.member?(y, x) end)
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
    # flip src and dest from part 1, as we'll run this in reverse
    [src, dest, length] =
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
