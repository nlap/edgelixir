defmodule EdgelixirTest do
  use ExUnit.Case
  doctest Edgelixir

  test "default behavior options" do
    assert {%Edgelixir.GraphSources.File{path: "a"}, %Edgelixir.GraphOutputs.Stdout{}} = Edgelixir.parse_config(graph_input: %Edgelixir.GraphSources.File{path: "a"})
  end
  
  test "custom behavior options" do
    assert {"a", "b"} = Edgelixir.parse_config(graph_input: "a", graph_output: "b")
  end

  test "all nodes contains self" do
    assert Edgelixir.Helper.all_nodes == [Node.self]
  end

  test "node count" do
    assert Edgelixir.Helper.nodes_count == 1
  end

end
