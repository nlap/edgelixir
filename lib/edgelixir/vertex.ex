defmodule Edgelixir.Vertex do

  @moduledoc """
  A wrapper struct for a graph vertex
  """

  @enforce_keys [:id]
  defstruct id: nil, value: 0, neighbours: [], halted: false

end