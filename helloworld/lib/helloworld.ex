defmodule Helloworld do
  @moduledoc """
  Sniffi pagliaccio 2
  """

  @doc """
  Hello world.

  ## Examples

      iex> Helloworld.hello()
      :world

  """
  def buildQueue do
    PriorityQueue.new |> PriorityQueue.empty?
  end
end
