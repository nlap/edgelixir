defmodule Edgelixir.Superstep do
  require Logger
  use GenServer

  @moduledoc """
  An Elixir OTP GenServer that manages Pregel supersteps on each cluster node
  """

  ## Client API

  @doc """
  Starts the superstep supervisor server
  """
  def start_link(args) do
    IO.puts __MODULE__
    {:ok, args} = GenServer.start_link(__MODULE__, [parent: args, barriers: 0], name: :superstep)
  end

  @doc """
  A distributed synchronization barrier for supersteps or graph loading

  ## Examples

      # each node waits until all nodes call barrier/0
      iex> Edgelixir.Superstep.barrier
      {:ok, 1}

  """
  @spec barrier() :: {:reply, reply :: term, state :: term}
  def barrier() do
    GenServer.multi_call(:superstep, :barrier)
  end

  @doc """
  Sends a message to all vertex neighbors

  ## Arguments:

  - `vertex` (%Edgelixir.Vertex) vertex to send message from
  - `message` (Any) message to send to neighboring edges

  ## Examples

      iex> Edgelixir.Superstep.send_message_to_neighbors(vertex, 1)
      {:ok, 1}

  """
  @spec send_message_to_neighbours(vertex :: %Edgelixir.Vertex{}, message :: any) :: {:reply, reply :: term, state :: term}
  def send_message_to_neighbours(vertex, message) do
    GenServer.multi_call(:superstep, {:message, vertex.id, message})
  end

  @doc """
  Called by vertex to remove itself from further processing,
  unless it receives a new incoming message

  ## Arguments:

  - `vertex` (Edgelixir.Vertex) vertex voting to halt
  """
  @spec vote_to_halt(vertex :: Edgelixir.Vertex) :: {:reply, reply :: term, state :: term}
  def vote_to_halt(vertex) do
    
  end

  @doc """
  Updates a vertex value in the underlying representation

  ## Arguments:

  - `vertex` (Edgelixir.Vertex) struct of vertex to update, with new value
  """
  @spec update_vertex(vertex :: Edgelixir) :: none
  def update_vertex(vertex) do
    
  end

  ## Server Callbacks

  # distributed synchronization barrier
  # performs next superstep once barrier hit by all nodes
  def handle_call(:barrier, from, state) do

    # new node hits the barrier, check if they all have
    nodes_count = Edgelixir.Helper.nodes_count - 1
    barriers_updated = case state[:barriers] do
      ^nodes_count -> 0
      _ -> state[:barriers] + 1
    end

    state_updated = [parent: state[:parent], barriers: barriers_updated]

    # all nodes hit barrier, run superstep
    if barriers_updated == 0 do
      IO.puts "running"
      state[:parent].compute([],[],[])
      if Node.self == :"node1@127.0.0.1" do
        Process.sleep 1000
      end
    end

    {:reply, state_updated, state_updated}
  end

  def handle_call({:message, vertex, message}, _from, messages) do
    messages = Map.put_new(messages, vertex, message)
    {:reply, [], messages}
  end

end
