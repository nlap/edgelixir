defprotocol Edgelixir.GraphInput do

  @moduledoc """
  Specifies how the graph data is loaded
  """

  @doc """
  Loads the graph from the source, or raises an exception if unable

  Takes a `graph_source`, `graph_format`. Returns a loaded `:digraph`.
  """
  @spec load!(any) :: :digraph.t
  def load!(graph_source)
end

defimpl Edgelixir.GraphInput, for: Edgelixir.GraphSources.File do
  def load!(%Edgelixir.GraphSources.File{path: path}) do
    graph = :digraph.new()
    file = File.read! path
    Application.fetch_env!(:edgelixir, :graph_format).store_vertex(graph, file)
    Application.fetch_env!(:edgelixir, :graph_format).store_edge(graph, file)
    graph
  end
end

defimpl Edgelixir.GraphInput, for: Edgelixir.GraphSources.URL do
  def load!(%Edgelixir.GraphSources.URL{url: url}) do
    graph = :digraph.new()
    body = HTTPoison.get!(url).body
    Application.fetch_env!(:edgelixir, :graph_format).store_vertex(graph, body)
    Application.fetch_env!(:edgelixir, :graph_format).store_edge(graph, body)
    graph
  end
end
