defmodule Aoc2023.Day03Test do
  use ExUnit.Case

  describe "Part 1" do
    import Aoc2023.Day03.Part01
    @test_data [
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598.."
    ]

    test "provided test case" do
      assert solve(@test_data) == 4361
    end

    test "given line and index, return nums and coordinates" do
      expected_result = [{0, 0, 3, 467}, {5, 0, 3, 114}]
      assert get_num_coords(hd(@test_data), 0) == expected_result
    end
    
    test "given line and index, return coordinates of symbols" do
      input_data = hd(tl(@test_data))
      expected_result = [{3, 1}]
      assert get_symbol_coords(input_data, 1) == expected_result
    end

    test "given full input data, return list of num_tuples" do
      expected_result = [
        {0, 0, 3, 467},
        {5, 0, 3, 114},
        {2, 2, 2, 35},
        {6, 2, 3, 633},
        {0, 4, 3, 617}, 
        {7, 5, 2, 58},
        {2, 6, 3, 592},
        {6, 7, 3, 755},
        {1, 9, 3, 664},
        {5, 9, 3, 598}
      ]

      assert get_all_num_coords(@test_data) == expected_result
    end

    test "given full input data, return list of symbol_tuples" do
      expected_result = [
        {3, 1},
        {6, 3},
        {3, 4},
        {5, 5},
        {3, 8},
        {5, 8}
      ]

      assert get_all_symbol_coords(@test_data) == expected_result
    end

    test "given a num_tuple check against all symbol_tuples" do
      symbol_tuples = get_all_symbol_coords(@test_data)
      assert is_part_num?({0, 0, 3, 467}, symbol_tuples) == true
      assert is_part_num?({5, 0, 3, 114}, symbol_tuples) == false
    end

    test "given the full input, get only the numbers that are part numbers" do
      part_nums = get_all_part_nums(@test_data)
      dbg(part_nums)
      assert length(part_nums) == 8
    end
  end

  describe "Part2" do
    import Aoc2023.Day03.Part02
    @test_data [
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598.."
    ]

    test "provided test case" do
      assert solve(@test_data) == 467835
    end
    
    test "get_all_symbol_coords only gets *s" do
      coords = get_all_symbol_coords(@test_data)
      assert length(coords) == 3
    end

    test "get_adj_nums/2 returns only nums adjacent to the provided symbol" do
      symbol = {4,1}
      nums = get_all_num_coords(@test_data)
      adj_nums = get_adj_nums(symbol, nums)
      assert length(adj_nums) == 2
    end
  end
  
end
