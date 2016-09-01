defmodule Edgelixir.GraphSources.URL do

  @moduledoc """
  A built-in GraphSource to load a graph from an HTTP/HTTPS URL

  ## Arguments

  * `:url` (String) An http:// or https:// URL that resolves on each node

  Note: The URL may be for a distributed file system, such as HDFS via HttpFS

  ## Todo

  This may be expanded in the future to allow POST data to be passed (e.g. auth tokens, etc.)
  """

  defstruct [:url]
end
