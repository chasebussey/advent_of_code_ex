defmodule Aoc2023.Day04.Part02 do
  import Util
  alias Aoc2023.Day04.Card
  
  def solve() do
    read_input("./day04_input.txt")
    |> Enum.map(&String.trim/1)
    |> solve()
  end

  def solve(input) do
    input
    |> Enum.map(&parse_card/1)
    |> apply_winnings(0)
  end

  def parse_card(str) do
    card_num = 
      str
      |> String.split(":")
      |> hd()
      |> String.trim()
      |> String.split(" ")
      |> List.last()
      |> String.to_integer()

    [winning_num_str | [match_num_str]] = 
      str
      |> String.split(":")
      |> List.last()
      |> String.trim()
      |> String.split("|")

    winning_nums = to_int_array(winning_num_str)
    match_nums = to_int_array(match_num_str)

    match_num = 
      winning_nums
      |> Enum.filter(fn x -> Enum.member?(match_nums, x) end)
      |> Enum.count()

    %Card{card_num: card_num, matches: match_num, copies: 1}
  end

  def apply_winnings([card | []], sum_of_copies) do
    dbg(card)
    sum_of_copies + card.copies
  end
  
  def apply_winnings([card | cards], sum_of_copies) do
    dbg(card)
    sum_of_copies = sum_of_copies + card.copies

    updated_cards =
      Enum.filter(cards, fn x -> x.card_num > card.card_num and x.card_num <= card.card_num + card.matches end)
      |> Enum.map(fn x -> %Card{card_num: x.card_num, matches: x.matches, copies: x.copies + card.copies} end)

    other_cards = Enum.filter(cards, fn x -> x.card_num > card.card_num + card.matches end)
    remaining_cards = updated_cards ++ other_cards
      
    apply_winnings(remaining_cards, sum_of_copies)
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
