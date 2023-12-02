defmodule Aoc2023.Day01Test do
  use ExUnit.Case

  describe "Part01" do
    import Aoc2023.Day01.Part01

    test "gets calibration value for line" do
      assert get_calibration_val("1hello2world3") == 13
    end
    
    test "given enumerable of lines, returns sum of calibration values" do
      lines = ["1hello2world3", "2hello3world4", "3hello4world5"]
      assert sum_calibration_vals(lines) == 72
    end
  end
  
  describe "Part02" do
    import Aoc2023.Day01.Part02

    test "gets calibration value for line" do
      assert get_calibration_val("1hello2world3") == 13
    end
    
    test "given input that only matches part 1 pattern, returns sum of calibration values" do
      lines = ["1hello2world3", "2hello3world4", "3hello4world5"]
      assert sum_calibration_vals(lines) == 72
    end

    test "given input with digit words, returns sum of calibration values" do
      lines = ["onehello2world3", "2hellothreeworldfour", "threehellofourworldfive"]
      assert sum_calibration_vals(lines) == 72
    end

    test "single digit input works" do
      lines = ["8"]
      assert sum_calibration_vals(lines) == 88
    end
    
    test "single word input works" do
      lines = ["eight"]
      assert sum_calibration_vals(lines) == 88
    end
    
    test "overlapping digit words works" do
      lines = ["1anwsaojsaijqwoida"]
      assert sum_calibration_vals(lines) == 11 
    end
    
    test "even more overlapping digit words works" do
      lines = ["twonetwo"]
      assert sum_calibration_vals(lines) == 22
    end
  end 
end
