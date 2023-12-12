defmodule Aoc2023.Day07.Part02 do
  alias Aoc2023.Day07.Hand
  import Util

  @hand_strength %{
    high_card:       0,
    one_pair:        1,
    two_pair:        2,
    three_of_a_kind: 3,
    full_house:      4,
    four_of_a_kind:  5,
    five_of_a_kind:  6
    }

    @face_card_vals %{
      84 => 10,
      74 => 1,
      81 => 12,
      75 => 13,
      65 => 14
    }
  
  def solve() do
    read_input("./input/aoc2023/day07_input.txt")
    |> solve
  end
  
  def solve(input) do
    input
    |> to_hands()
    |> sort_hands()
    |> Enum.with_index()
    |> Enum.map(&calculate_winnings/1)
    |> Enum.sum()
  end

  def to_hands(lines) do
    Enum.map(lines, fn x -> to_hand(x) end)
  end

  def to_hand(line) do
    [hand_str, bid] =
      line
      |> String.split(" ")
      |> Enum.map(&String.trim/1)

    bid = String.to_integer(bid)

    %Hand{hand_str: hand_str, bid: bid, hand_type: get_hand_type(hand_str)}
  end
  
  def get_hand_type(hand_str) do
    case String.contains?(hand_str, "J") do
      true -> get_hand_type_with_joker(hand_str)
      false -> get_hand_type_no_joker(hand_str)
    end
  end

  def get_hand_type_with_joker(hand_str) do
    cards = String.to_charlist(hand_str)
    num_jokers = Enum.count(cards, fn x -> x == ?J end)

    unique_cards = 
      cards
      |> Enum.filter(fn x -> x != ?J end)
      |> Enum.uniq()

    [highest | _others] = case length(unique_cards) > 0 do
      true -> 
        unique_cards
          |> Enum.map(fn x -> Enum.count(cards, fn y -> y == x end) end)
          |> Enum.sort(:desc)
      false -> [-1 | []]
    end
    
    case highest + num_jokers - length(unique_cards) do
      -2 -> :one_pair
      0  -> :three_of_a_kind
      1  -> :full_house
      2  -> :four_of_a_kind
      4  -> :five_of_a_kind
    end
  end

  def get_hand_type_no_joker(hand_str) do
    unique_cards =
      hand_str
      |> String.to_charlist()
      |> Enum.uniq()

    case length(unique_cards) do
      1 -> :five_of_a_kind
      2 -> full_house_or_four_of_a_kind?(hand_str, unique_cards)
      3 -> two_pair_or_three_of_a_kind?(hand_str, unique_cards)
      4 -> :one_pair
      5 -> :high_card
    end
  end

  def full_house_or_four_of_a_kind?(hand_str, unique_cards) do
    first_occurrences =
      hand_str
      |> String.to_charlist()
      |> Enum.count(fn x -> x == Enum.at(unique_cards, 0) end)

    case first_occurrences do
      1 -> :four_of_a_kind
      2 -> :full_house
      3 -> :full_house
      4 -> :four_of_a_kind
    end
  end

  def two_pair_or_three_of_a_kind?(hand_str, unique_cards) do
    cards =
      hand_str
      |> String.to_charlist()

    has_pair =
      unique_cards
      |> Enum.any?(fn x -> Enum.count(cards, fn y -> y == x end) == 2 end)

    case has_pair do
      true -> :two_pair
      _ -> :three_of_a_kind
    end
  end
  
  def sort_hands(hands) do
    hands
    |> Enum.sort(&sort_hands(&1, &2))
  end

  def sort_hands(hand1, hand2) do
    if hand1.hand_type == hand2.hand_type do
      sort_by_high_card(hand1, hand2)
    else
      sort_by_hand_type(hand1, hand2)
    end
  end

  def sort_by_high_card(hand1, hand2) do
    hand1 = convert_to_card_vals(hand1.hand_str) |> Enum.to_list()
    hand2 = convert_to_card_vals(hand2.hand_str) |> Enum.to_list()
    compare_cards(hand1, hand2, 0)
  end

  def sort_by_hand_type(hand1, hand2) do
    @hand_strength[hand1.hand_type] < @hand_strength[hand2.hand_type]
  end

  def compare_cards(hand1, hand2, index) do

    case Enum.at(hand1, index) == Enum.at(hand2, index) do
      true -> compare_cards(hand1, hand2, index + 1)
      false -> Enum.at(hand1, index) < Enum.at(hand2, index)
    end
  end

  def convert_to_card_vals(hand) do
    hand
    |> String.to_charlist()
    |> Enum.map(&convert_to_card_val/1)
  end

  def convert_to_card_val(card) do
    case card > 64 do
      true -> @face_card_vals[card]
      false -> card - 48
    end
  end

  def calculate_winnings({%Hand{} = hand, rank}) do
    hand.bid * (rank + 1)
  end
end
