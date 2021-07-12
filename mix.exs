defmodule KgbScrape.MixProject do
  use Mix.Project

  def project do
    [
      app: :kgbScrapeApp,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.20.0"},
      {:earmark, "~> 1.2"},
      {:ex_doc, "~> 0.19.0"},
    ]
  end
end
