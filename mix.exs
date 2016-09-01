defmodule Edgelixir.Mixfile do
  use Mix.Project

  def project do
    [app: :edgelixir,
     version: "0.1.0",
     elixir: "~> 1.3",
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.9.0"},
     {:credo, "~> 0.4", only: [:dev, :test]},
     {:ex_doc, "~> 0.12", only: :dev},
     {:excoveralls, "~> 0.5", only: :test},
     {:inch_ex, "~> 0.5", only: [:dev, :test]}]
  end

  defp description do
    """
    Pregel-like Distributed Graph Processing in Elixir
    """
  end

  defp package do
    [maintainers: ["Nathan Lapierre"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/nlap/edgelixir",
              "Docs" => "https://hexdocs.pm/edgelixir/",
              "Site" => "https://edgelixir.net"}]
  end
end