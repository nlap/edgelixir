defmodule Edgelixir.GraphPartition do

  @moduledoc """
  Implementations specify how the graph is partitioned across the cluster
  """

  @doc """
  Return a node name atom that this graph property belongs to

  Typically a simple graph property, such as vertex id, is used to partition the graph.
  However, `vertex` is an Edgelixir.Vertex struct which may hold other properties.
  """
  @callback node_name(vertex :: Edgelixir.Vertex) :: Atom.t
end
