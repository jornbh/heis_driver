defmodule HeisDriver.MixProject do
  use Mix.Project

  def project do
    [
      app: :heis_driver,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      author: "Jørn Bøni Hofstad",
      #docs
      source_url: "https://github.com/jornbh/heis_driver",
      docs: [
        main: "Driver",
        extras: ["README.md"],
        dialyzer: [ flags: ["-Wunmatched_returns", :error_handling, :underspecs]],
      ]

    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      registered: [Driver]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
