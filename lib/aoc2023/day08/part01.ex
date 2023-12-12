defmodule Aoc2023.Day08.Part01 do
  import Util

  def solve do
    read_input("./input/aoc2023/day08_input.txt")
    |> solve
  end

  def solve(input) do
    {instructions, network} = parse(input)
    dbg(instructions)
    traverse("AAA", network, 0, instructions, instructions)
  end

  def parse(input) do
    [instructions_str | node_list] = Enum.reject(input, fn x -> x == "\n" end)
    
    {
      String.split(instructions_str, "", trim: true) |> Enum.reject(fn x -> x == "\n" end),
      parse_network(node_list)
    }
  end

  def parse_network(node_list) do
    node_list
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_node/1)
    |> Map.new()
  end

  def parse_node(node) do
    <<key::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3), ")">> = node
    {key, {left, right}}
  end

  def traverse(key, network, count, instructions, []) do
    traverse(key, network, count, instructions, instructions)
  end
  
  def traverse(key, network, count, instructions, [dir | dirs]) do
    if (key == "ZZZ") do
      count
    else
      {left, right} = network[key]
      case dir do
        "R" -> traverse(right, network, count + 1, instructions, dirs)
        "L" -> traverse(left, network, count + 1, instructions, dirs)
      end
    end

  end

end
