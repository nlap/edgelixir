defmodule GraphFormatTest do
  use ExUnit.Case

  test "simple edgelist format works" do
    graph = :digraph.new
    Application.fetch_env!(:edgelixir, :graph_format).store_vertex(graph, "7,11\n")
    Application.fetch_env!(:edgelixir, :graph_format).store_edge(graph, "7,11\n")
    assert :digraph.vertices(graph) == [11,7]
    [head | tail] = :digraph.vertices(graph)
    assert head == 11
    assert tail == [7]
  end

end
