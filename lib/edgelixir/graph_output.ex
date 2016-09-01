defprotocol Edgelixir.GraphOutput do

  @moduledoc """
  Implementations specify how the compute result is outputted
  """

  @doc """
  Outputs the compute result
  """
  @spec write!(any) :: none
  def write!(data)
end

defimpl Edgelixir.GraphOutput, for: Edgelixir.GraphOutputs.Stdout do
  def write!(_) do
    IO.puts("output graph to standard io")
  end
end
