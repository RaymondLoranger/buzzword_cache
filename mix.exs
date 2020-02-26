defmodule Buzzword.Cache.MixProject do
  use Mix.Project

  def project do
    [
      app: :buzzword_cache,
      version: "0.1.7",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
      # dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Buzzword.Cache.Top, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:log_reset, "~> 0.1"},
      {:file_only_logger, "~> 0.1"},
      {:persist_config, "~> 0.1", runtime: false},
      {:logger_file_backend, "~> 0.0.9"},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
