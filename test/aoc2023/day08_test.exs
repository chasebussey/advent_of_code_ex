defmodule Aoc2023.Day08Test do
  use ExUnit.Case

  describe "Part 1" do
    import Aoc2023.Day08.Part01

    @test_data [
      "RL",
      "AAA = (BBB, CCC)",
      "BBB = (DDD, EEE)",
      "CCC = (ZZZ, GGG)",
      "DDD = (DDD, DDD)",
      "EEE = (EEE, EEE)",
      "GGG = (GGG, GGG)",
      "ZZZ = (ZZZ, ZZZ)"
    ]

    test "provided test case 1" do
      assert solve(@test_data) == 2
    end
  end

  describe "Part 2" do
    import Aoc2023.Day08.Part02

    @test_data [
      "LR",
      "11A = (11B, XXX)",
      "11B = (XXX, 11Z)",
      "11Z = (11B, XXX)",
      "22A = (22B, XXX)",
      "22B = (22C, 22C)",
      "22C = (22Z, 22Z)",
      "22Z = (22B, 22B)",
      "XXX = (XXX, XXX)"
    ]

    test "provided test case 1" do
      assert solve(@test_data) == 6
    end

  end
end
