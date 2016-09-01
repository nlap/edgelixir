# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :edgelixir,
  partition_scheme: Edgelixir.PartitionSchemes.EdgeCut,
  graph_format: Edgelixir.GraphFormats.EdgelistSimple,
  max_supersteps: 3