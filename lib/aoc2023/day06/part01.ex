defmodule Aoc2023.Day06.Part01 do
  import Util
   @eps 0.01

  def solve() do
    read_input("input/aoc2023/day06_input.txt")
    |> solve
  end

  def solve(input) do
    input
    |> to_time_dist_pairs
    |> Enum.map(&get_ways_to_win/1)
    |> Enum.product()
  end

  def to_time_dist_pairs(input) do
    input
    |> Enum.map(&to_num_list/1)
    |> Enum.zip()
  end

  def get_ways_to_win({t, d}) do
    # final_dist = c(t - c)
    # c^2 - tc + (d + 1) = 0
    # find roots for c, take integer parts (to discretize), then take the difference
    roots = 
      {t, d}
      |> find_quadratic_roots

    elem(roots, 1) - elem(roots, 0)
  end

  def find_quadratic_roots({t, d}) do
    b_square = Float.pow(t, 2)
    ac = (d + @eps)

    first_root = 
      (-t + Float.pow(b_square - (4 * ac), 0.5)) / 2
      |> trunc()
      |> abs()

    second_root = 
      (-t - Float.pow(b_square - (4 * ac), 0.5)) / 2
      |> trunc()
      |> abs()

    {first_root, second_root}
  end

  defp to_num_list(input_str) do
    input_str
    |> String.split(":")
    |> List.last()
    |> String.trim()
    |> String.split(" ")
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&Float.parse/1)
    |> Enum.map(fn x -> elem(x, 0) end)
  end
end
