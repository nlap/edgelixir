use Mix.Config

config :edgelixir,
  partition_scheme: Edgelixir.PartitionSchemes.EdgeCut,
  graph_format: Edgelixir.GraphFormats.EdgelistSimple,
  max_supersteps: 30


