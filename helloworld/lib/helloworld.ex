defmodule Helloworld do
  @moduledoc """
  Sniffi pagliaccio 2
  """

  @spec buildQueue :: boolean
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
