defmodule Edgelixir.GraphSources.File do

  @moduledoc """
  A built-in GraphSource to load a graph from a file

  ## Arguments

  * `:path` (String) A relative or absolute path to a file. The file must exist on each node.
  """

  defstruct [:path]
end
