defmodule Aoc2023.Day04.Part01 do
  import Util
  
  def solve() do
    read_input("./day04_input.txt")
    |> Enum.map(&String.trim/1)
    |> solve()
  end

  def solve(input) do
    input
    |> Enum.map(&get_score_for_card/1)
    |> Enum.sum()
  end
  
  def get_score_for_card(card) do
    case get_num_matches(card) do
      0 -> 0
      x -> Integer.pow(2, x - 1)
    end
  end
  
  def get_num_matches(card) do
    [winning_num_str | [match_num_str]] = 
      String.split(card, ":")
      |> List.last()
      |> String.trim()
      |> String.split("|")

    winning_nums = to_int_array(winning_num_str)
    match_nums = to_int_array(match_num_str)

    winning_nums
    |> Enum.filter(fn x -> Enum.member?(match_nums, x) end)
    |> Enum.count()
  end

  defp to_int_array(str) do
    str
    |> String.split(" ")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&String.to_integer/1)
  end
end
