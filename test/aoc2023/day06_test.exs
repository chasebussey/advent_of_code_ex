defmodule Aoc2023.Day06Test do
  use ExUnit.Case

  describe "Part 1" do
    import Aoc2023.Day06.Part01

    @test_data [
      "Time:     7 15 30",
      "Distance: 9 40 200"
    ]

    test "find_quadratic_roots/1 given {30.0, 200.0} returns {10, 19}" do
      assert find_quadratic_roots({30.0, 200.0}) == {10, 19}
    end
    
    test "provided test case" do
      assert solve(@test_data) == 288
    end
  end

  describe "Part 2" do
    import Aoc2023.Day06.Part02

    @test_data [
      "Time:     7 15 30",
      "Distance: 9 40 200"
    ]

    test "provided test case" do
      assert solve(@test_data) == 71503
    end
  end
end
