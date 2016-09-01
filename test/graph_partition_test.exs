defmodule GraphPartitionTest do
  alias Edgelixir.PartitionSchemes
  use ExUnit.Case

  # to improve
  test "edge cut partitioning works for one node" do
    assert PartitionSchemes.EdgeCut.node_name(%Edgelixir.Vertex{id: 0}) == Node.self
  end

end
