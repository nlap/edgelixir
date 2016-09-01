defmodule Edgelixir do

  @moduledoc """
  Behaviour to build Pregel-like distributed graph processing in Elixir
  """

  @doc """
  Pregel compute function. Must be implemented by Edgelixir user.
  """
  @callback compute(String.t) :: any

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use Application
      alias Edgelixir.GraphInput
      require Logger

      @behaviour Edgelixir

      {graph_input, graph_output} = Edgelixir.parse_config(opts)
      @graph_input graph_input
      @graph_output graph_output
      @max_supersteps Application.fetch_env!(:edgelixir, :max_supersteps)
      @parent __MODULE__

      def start(_type, _args) do
        import Supervisor.Spec, warn: false

        # start superstep genserver
        Logger.info "Started edgelixir"
        children = [worker(Edgelixir.Superstep, [@parent])]

        opts = [strategy: :one_for_one, name: Edgelixir.Supervisor]
        {:ok, pid} = Supervisor.start_link(children, opts)

        # load graph
        graph = GraphInput.load!(@graph_input)
        Logger.info "Loaded graph"

        Edgelixir.Superstep.barrier

        for n <- 0..@max_supersteps do
          IO.puts n
          Edgelixir.Superstep.barrier
        end

        {:ok, pid}
      end
    end
  end

  @doc """
  Parses the graph configuration when using the behaviour
  """
  def parse_config(opts) do
    graph_input = Keyword.fetch!(opts, :graph_input)
    graph_output = opts[:graph_output] || %Edgelixir.GraphOutputs.Stdout{}

    {graph_input, graph_output}
  end
end

defmodule Edgelixir.Helper do
  @moduledoc """
  Provides helper functions that may be used throughout the library
  """

  @doc """
  Lists all connected nodes, including the current node
  """
  def all_nodes do
    Node.list
    |> List.insert_at(-1, Node.self)
    |> Enum.sort
  end

  @doc """
  A count of all connected nodes
  """
  def nodes_count do
    Enum.count all_nodes()
  end
end
