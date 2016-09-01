defmodule Edgelixir.GraphFormat do

  @moduledoc """
  Implementations specify how graph data is parsed
  """

  @doc """
  Parses and stores vertices from the graph data into a :digraph
  """
  @callback store_vertex(graph :: :digraph.t, raw_data :: any) :: none

  @doc """
  Parses and stores edges from the graph data into a :digraph
  """
  @callback store_edge(graph :: :digraph.t, raw_data :: any) :: none
end
