defmodule Aoc2023.Day05Test do
  alias Aoc2023.Day05.CategoryMap
  use ExUnit.Case

  describe "Part 1" do
    import Aoc2023.Day05.Part01
    @test_data [
      "seeds: 79 14 55 13",
      "\n",
      "seed-to-soil map:",
      "50 98 2",
      "52 50 48",
      "\n",
      "soil-to-fertilizer map:",
      "0 15 37",
      "37 52 2",
      "39 0 15",
      "\n",
      "fertilizer-to-water map:",
      "49 53 8",
      "0 11 42",
      "42 0 7",
      "57 7 4",
      "\n",
      "water-to-light map:",
      "88 18 7",
      "18 25 70",
      "\n",
      "light-to-temperature map:",
      "45 77 23",
      "81 45 19",
      "68 64 13",
      "\n",
      "temperature-to-humidity map:",
      "0 69 1",
      "1 0 69",
      "\n",
      "humidity-to-location map:",
      "60 56 37",
      "56 93 4"
    ]

    test "provided test case" do
      assert solve(@test_data) == 35
    end
  end

  describe "Part 2" do
    import Aoc2023.Day05.Part02
    @test_data [
      "seeds: 79 14 55 13",
      "\n",
      "seed-to-soil map:",
      "50 98 2",
      "52 50 48",
      "\n",
      "soil-to-fertilizer map:",
      "0 15 37",
      "37 52 2",
      "39 0 15",
      "\n",
      "fertilizer-to-water map:",
      "49 53 8",
      "0 11 42",
      "42 0 7",
      "57 7 4",
      "\n",
      "water-to-light map:",
      "88 18 7",
      "18 25 70",
      "\n",
      "light-to-temperature map:",
      "45 77 23",
      "81 45 19",
      "68 64 13",
      "\n",
      "temperature-to-humidity map:",
      "0 69 1",
      "1 0 69",
      "\n",
      "humidity-to-location map:",
      "60 56 37",
      "56 93 4"
    ]

    test "provided test case" do
      assert solve(@test_data) == 46
    end
  end
end
