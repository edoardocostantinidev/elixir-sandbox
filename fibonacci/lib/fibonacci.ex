defmodule Fibonacci do
  defmodule Fibonacci.Naive do
    def compute(0) do
      0
    end

    def compute(1) do
      1
    end

    @spec compute(integer) :: integer
    def compute(n) do
      compute(n - 1) + compute(n - 2)
    end
  end

  defmodule Fibonacci.DP do
    def compute(n) do
      cache = %{0 => 0, 1 => 1}

      cache =
        Enum.reduce(2..n, cache, fn
          i, acc ->
            Map.put(acc, i, acc[i - 2] + acc[i - 1])
        end)

      cache[n]
    end
  end

  defmodule Fibonacci.Map do
    def compute(n) do
      compute(2, n, %{0 => 0, 1 => 1})
    end

    def compute(n, target, map) when n == target do
      map[n - 1] + map[n - 2]
    end

    def compute(n, target, map) do
      value = map[n - 1] + map[n - 2]
      newMap = Map.put(map, n, value)
      compute(n + 1, target, newMap)
    end
  end

  defmodule Fibonacci.Iterative do
    def compute(n) do
      iter_fib(n)
    end

    def iter_fib(0) do
      1
    end

    def iter_fib(1) do
      1
    end

    def iter_fib(index) do
      Enum.reduce(2..index, [1, 1], fn _i, acc ->
        # Calculate the Fibonacci value
        # Take the accumulator
        fib_val =
          acc
          # Flatten the list since we're appending fib_val by a new list
          |> List.flatten()
          # Sum those values
          |> Enum.sum()

        [Enum.take(acc, -1), fib_val]
      end)
      # This is now the previous Fibonacci value and index's value, so just take the last value
      |> List.last()
    end
  end

  defmodule Fibonacci.Formula do
    require Float

    def compute(n) do
      x1 = 1 / :math.sqrt(5)
      x2 = Float.pow((1 + :math.sqrt(5)) / 2, n)
      y1 = 1 / :math.sqrt(5)
      y2 = Float.pow((1 - :math.sqrt(5)) / 2, n)
      x1 * x2 - y1 * y2
    end
  end

  def compute(n) do
    naiveCompute = fn n -> Fibonacci.Naive.compute(n) end
    mapCompute = fn n -> Fibonacci.Map.compute(n) end
    dpCompute = fn n -> Fibonacci.DP.compute(n) end
    iterCompute = fn n -> Fibonacci.Iterative.compute(n) end
    formulaCompute = fn n -> Fibonacci.Formula.compute(n) end

    if n < 40 do
      {naiveUsec, naiveValue} = :timer.tc(naiveCompute, [n])
      IO.puts("[NAIVE] #{naiveValue} computed in: #{naiveUsec} microseconds")
    end

    if n < 1_000_000 do
      {mapUSecs, _} = :timer.tc(mapCompute, [n])
      IO.puts("[MAP] computed in: #{mapUSecs} microseconds")
      {dpUSecs, _} = :timer.tc(dpCompute, [n])
      IO.puts("[DP] computed in: #{dpUSecs} microseconds")
      {iterUSecs, _} = :timer.tc(iterCompute, [n])
      IO.puts("[ITER] computed in: #{iterUSecs} microseconds")
    end

    {iterUSecs, iterValue} = :timer.tc(formulaCompute, [n])
    IO.puts("[Formula] #{iterValue} computed in: #{iterUSecs} microseconds")
  end
end
