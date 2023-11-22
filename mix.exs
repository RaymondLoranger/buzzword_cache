defmodule Buzzword.Cache.MixProject do
  use Mix.Project

  def project do
    [
      app: :buzzword_cache,
      version: "0.1.6",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Buzzword Cache",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
      # dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/buzzword_cache"
  end

  defp description do
    """
    Buzzword Cache for the Multi-Player Buzzword Bingo game.
    """
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README*",
        "config/persist*.exs",
        "assets/buzzwords.csv"
      ],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
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
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:file_only_logger, "~> 0.2"},
      {:log_reset, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
