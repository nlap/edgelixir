defmodule Edgelixir.PartitionSchemes.EdgeCut do

  @behaviour Edgelixir.GraphPartition
  alias Edgelixir.Helper

  @moduledoc """
  A built-in PartitionScheme to partition the graph by vertex (cutting edges)

  ## Arguments

  This scheme takes no arguments

  ## Algorithm

  node = vertex.id % number_of_nodes
  """

  def node_name(vertex) do
    Enum.at(Helper.all_nodes, rem(vertex.id, length(Helper.all_nodes)))
  end
end
