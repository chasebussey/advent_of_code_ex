defmodule Aoc2023.Day01.Part02 do
  import Util

  @digit_words %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  @digits_regex          ~r/[1-9]|one|two|three|four|five|six|seven|eight|nine/
  @reversed_digits_regex ~r/[1-9]|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/

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
    |> parse_digit()
  end

  defp get_first_digit(line, :reverse) do
    line = String.trim(line)

    Regex.run(@reversed_digits_regex, line)
    |> hd()
    |> String.reverse()
    |> parse_digit()
  end
  
  defp get_last_digit(line) do
    String.reverse(line)
    |> get_first_digit(:reverse)
  end
  
  defp parse_digit(digit) do
    case Integer.parse(digit) do
      {x, _} -> x
      :error -> @digit_words[digit]
    end
  end
end
