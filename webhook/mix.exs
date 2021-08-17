defmodule Webhook.MixProject do
  use Mix.Project

  def project do
    [
      app: :webhook,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {Webhook.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:jason, "~> 1.2.2"},
      {:parent, "~> 0.12.0"}
    ]
  end
end
