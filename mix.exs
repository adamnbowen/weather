defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [app: :weather,
     version: "0.1.0",
     elixir: "~> 1.4",
     escript: escript_config(),
     name: "Weather",
     source_url: "https://github.com/adamnbowen/weather",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpoison, "0.11.2" },
      { :poison, "3.1.0" },
      { :ex_doc, "0.15.1" },
      { :earmark, "1.2.1", override: true}
    ]
  end
  
  defp escript_config do
    [ main_module: Weather.CLI ]
  end
end
