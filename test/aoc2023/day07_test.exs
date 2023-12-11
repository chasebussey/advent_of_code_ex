defmodule Aoc2023.Day07Test do
  alias Aoc2023.Day07.Hand
  use ExUnit.Case

  describe "Part 1" do
    import Aoc2023.Day07.Part01

    @test_data [
      "32T3K 765",
      "T55J5 684",
      "KK677 28",
      "KTJJT 220",
      "QQQJA 483"
    ]

    test "provided test case" do
      assert solve(@test_data) == 6440
    end

    test "high card sorts properly" do
      hand1 = %Hand{hand_str: "TQJKA", hand_type: :high_card}
      hand2 = %Hand{hand_str: "TQJ56", hand_type: :high_card}
      assert sort_hands(hand1, hand2) == false
    end
  end

  describe "Part 2" do
    import Aoc2023.Day07.Part02

    @test_data [
      "32T3K 765",
      "T55J5 684",
      "KK677 28",
      "KTJJT 220",
      "QQQJA 483"
    ]

    test "provided test case" do
      assert solve(@test_data) == 5905
    end

  end
end
