defmodule Aoc2023.Day01.Part01 do
  import Util

  @digits_regex ~r/[0-9]/

  def solve() do
    read_input("./day01_input.txt")
    |> sum_calibration_vals()
  end

  def sum_calibration_vals(lines) do
    Enum.reduce(lines, 0, fn line, acc -> get_calibration_val(line) + acc end)
  end

  def get_calibration_val(line) do
    (get_first_digit(line) * 10) + get_last_digit(line)
  end

  defp get_first_digit(line) do
    line = String.trim(line)

    Regex.run(@digits_regex, line)
    |> hd()
    |> String.to_integer()
  end

  defp get_last_digit(line) do
    String.reverse(line)
    |> get_first_digit()
  end
end
