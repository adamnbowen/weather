defmodule CliTest do
  use ExUnit.Case
  doctest Weather

  import Weather.CLI, only: [
    parse_args: 1,
    get_precip_today_in: 1
  ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "endpoint value returned" do
    assert parse_args([
      "conditions/q/CA/San_Francisco.json"
    ]) == { "conditions/q/CA/San_Francisco.json" }
  end
  
  test "gets the precipitation today in inches" do
    assert get_precip_today_in(
      %{"current_observation" => %{"precip_today_in" => "2.35"}}
    ) == "2.35"
  end
  # TODO: Test responses to valid endpoints
  # TODO: use keynotfound.json and success.json in tests somehow
end