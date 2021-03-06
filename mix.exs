defmodule Buzzword.Cache.MixProject do
  use Mix.Project

  def project do
    [
      app: :buzzword_cache,
      version: "0.1.17",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
      # dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Buzzword.Cache.TopSup, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:buzzword_bingo_square, github: "RaymondLoranger/buzzword_bingo_square"},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:file_only_logger, "~> 0.1"},
      {:log_reset, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
