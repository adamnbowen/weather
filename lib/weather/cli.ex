defmodule Weather.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that display info about the weather.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a endpoint to query.

  Return a tuple of `{ endpoint }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case  parse  do

    { [ help: true ], _, _ } 
      -> :help

    { _, [ endpoint ], _ } 
      -> { endpoint }

    _ -> :help

    end
  end
  
  def process(:help) do
    IO.puts """
    usage:  weather <endpoint>
    """
    System.halt(0)
  end

  def process({endpoint}) do
    Weather.Wunderground.fetch(endpoint)
    |> decode_response
  end
  
  def decode_response({:ok, body}) do
    body
    |> get_precip_today_in
    |> IO.puts
  end
  
  def decode_response({:error, error}) do
    description = error["description"]
    IO.puts "Error fetching from Wunderground: #{description}"
    System.halt(2)
  end
  
  def get_precip_today_in(%{"current_observation" => %{"precip_today_in" => precip_today_in}}), do: precip_today_in
end