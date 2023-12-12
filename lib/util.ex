defmodule Util do
  def read_input(path), do: File.stream!(path)

  def lcm(x, y) do
    div(x * y, Integer.gcd(x, y))
  end
end

