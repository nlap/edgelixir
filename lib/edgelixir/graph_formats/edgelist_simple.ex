defmodule Edgelixir.GraphFormats.EdgelistSimple do

  @behaviour Edgelixir.GraphFormat

  @moduledoc """
  A built-in GraphFormat for delimited edge lists, without vertex weights or labels

      1,2
      2,3
      3,1

  Vertex entries must be integers

  ## Mix Configuration

  * `:edgelist_delimiter` (String) Delimiter for source,destination vertices in edge entry. Default is ","
  """

  def store_vertex(graph, raw_data) do
    raw_data
    |> split_lines
    |> Enum.each(fn line ->
      [vertex1, vertex2] = parse_line(line)

      if in_partition?(%Edgelixir.Vertex{id: vertex1}), do: :digraph.add_vertex(graph, vertex1)
      if in_partition?(%Edgelixir.Vertex{id: vertex2}), do: :digraph.add_vertex(graph, vertex2)

    end)
  end

  def store_edge(graph, raw_data) do
    raw_data
    |> split_lines
    |> Enum.each(fn line ->
      [vertex1, vertex2] = parse_line(line)

      if in_partition?(%Edgelixir.Vertex{id: vertex1}) and in_partition?(%Edgelixir.Vertex{id: vertex2}) do
        :digraph.add_edge(graph, vertex1, vertex2)
      end

    end)
  end

  # edgelisit delimiter from config or default
  defp edgelist_delimiter() do
    case Application.fetch_env(:edgelixir, :edgelist_delimiter) do
      {:ok, delimiter} -> delimiter
      :error -> ","
    end
  end

  # split raw_data by line
  defp split_lines(raw_data) do
    String.split(raw_data, "\n", trim: true)
  end

  # splits line into source,dest vertices
  defp parse_line(line) do
    [vertex1, vertex2] = String.split(String.trim(line, "\n"), edgelist_delimiter(), trim: true)
    [String.to_integer(vertex1), String.to_integer(vertex2)]
  end

  # is vertex in current node's partition
  defp in_partition?(vertex) do
    Application.fetch_env!(:edgelixir, :partition_scheme).node_name(vertex) == Node.self
  end

end
