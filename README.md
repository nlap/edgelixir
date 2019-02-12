**This project is on indefinite hold and has no working release, but I hope that it might get you thinking about how to use Elixir for big data work often done in other languages/frameworks**

# Edgelixir
[![Build Status](https://travis-ci.org/nlap/edgelixir.svg?branch=master)](https://travis-ci.org/nlap/edgelixir) [![Coverage Status](https://coveralls.io/repos/github/nlap/edgelixir/badge.svg?branch=master)](https://coveralls.io/github/nlap/edgelixir?branch=master)

Edgelixir is a Pregel-like distributed graph processing package implemented in Elixir.

## Background

I started Edgelixir to help me learn and explore the strengths of Elixir and Erlang OTP for distributed, "big data" systems.

You can use this package to write distributed (or single machine) graph algorithms in the Pregel "think-like-a-vertex" model. Check out [their paper](https://scholar.google.ca/scholar?cluster=14900533813349353491&hl=en&as_sdt=0,5), or [here](https://blog.acolyer.org/2015/05/26/pregel-a-system-for-large-scale-graph-processing/) to learn about Pregel.

This project tries to implement Pregel concisely in Elixir, emphasizing:

* Extensibility (protocols/behaviours for graph loading, etc)
* Using Erlang OTP for the hard distributed systems/parallel stuff

**Early exploratory work**. If you need a production-ready, scalable graph system right away, go for Giraph, GraphX, GraphLab, etc.

Open to feedback and pull requests from everyone!

## Installation

The package can be installed [from Hex](https://hex.pm/packages/edgelixir):

  1. Add `edgelixir` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:edgelixir, "~> 0.1.0"}]
    end
    ```

  2. Ensure `edgelixir` is started before your application:

    ```elixir
    def application do
      [applications: [:edgelixir]]
    end
    ```

## Using
You should have an idea of how to implement your algorithm in Pregel. Lots have been implemented already for Giraph/GraphX (Java/Scala).

See `example/` for an example Edgelixir project with a small graph.

To use Edgelixir, use the behaviour in a new module, and pass the required `graph_input` argument:
	
	use Edgelixir, graph_input: %Edgelixir.GraphSources.File{path: "graphs/karateclub.edges"}
	
The other arguments (`graph_format`, `graph_output`, `graph_partition`) have basic defaults, but you'll probably need to pass your own for at least `graph_format`. [See the docs](https://hexdocs.pm/edgelixir/) for included types.

Next, you **must** implement `compute/2`. This function runs on each vertex, and receives the current vertex and any incoming messages. It's the core of the Pregel model, and your algorithm.

## Running distributed
Erlang has lots of docs on distributed config [[1]](http://erlang.org/doc/reference_manual/distributed.html) [[2]](http://erlang.org/doc/man/kernel_app.html).

A quick way to start is using the included `example/sys.config`, and running this on each node:

	iex --name node1@127.0.0.1 --cookie somesecurecookie --erl "-config sys.config" -S mix

## Todo
* Fault tolerance can be improved
	* Erlang continually checks node health (`net_ticktime`). Currently, depending on VM config, a dead node could trigger app restart on all other nodes, and the computation can start again on remaining live nodes. The better solution (as Pregel intends) would persist intermediate graph state at each superstep, and continute the computation from that state, not from scratch.
* Lots more...
