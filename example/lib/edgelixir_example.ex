defmodule EdgelixirExample do

  @moduledoc """
  A basic example of how to use Edgelixir

  Computes the PageRank in the included "Zachary's Karate Club" network
  """

  use Edgelixir, graph_input: %Edgelixir.GraphSources.File{path: "graphs/karateclub.edges"}

  def compute(vertex, messages, options) do
    
    sum = Enum.sum(messages)
    pagerank = 0.15 / options[:graph_size] + 0.85 * sum
    
    Edgelixir.Superstep.update_vertex(vertex, pagerank)
    Edgelixir.Superstep.message_neighbors(
      vertex, pagerank / Enum.size vertex.neighbours)

  end
end


