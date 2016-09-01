defmodule GraphInputTest do
  alias Edgelixir.GraphInput
  use ExUnit.Case

  test "file input works" do
    graph = GraphInput.load!(%Edgelixir.GraphSources.File{path: "test/test_graph.edges"})
    assert :digraph.vertices(graph) == [11,7]
    [head | tail] = :digraph.vertices(graph)
    assert head == 11
    assert tail == [7]
  end

  # todo: ideally use local cowboy server instead of remote server
  test "url input works" do
    graph = GraphInput.load!(%Edgelixir.GraphSources.URL{url: "https://gist.githubusercontent.com/nlap/a3c922bf72850f816ac951badf129b34/raw/288d4e10b09b7c74bf66deedf76540725a13e25c/test_graph.edges"})
    assert :digraph.vertices(graph) == [11,7]
    [head | tail] = :digraph.vertices(graph)
    assert head == 11
    assert tail == [7]
  end

end
