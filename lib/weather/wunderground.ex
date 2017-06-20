defmodule Weather.Wunderground do
  
  require Logger

  @user_agent  [ {"User-agent", "Weather weather@example.com"} ]

  @base_url Application.get_env(:weather, :base_url)
  @api_key Application.get_env(:weather, :api_key)

  def fetch(endpoint) do
    "#{@base_url}/#{@api_key}/#{endpoint}"
    |> HTTPoison.get(@user_agent)
    |> handle_response
    |> ensure_success
  end

  def handle_response({ :ok, %{status_code: 200,    body: body } }) do
    { :ok,    Poison.Parser.parse!(body) }
  end

  def handle_response({ _,   %{status_code: status, body: body} }) do
    Logger.error "Error #{status} returned"
    Logger.debug fn -> inspect(body) end
    { :error, Poison.Parser.parse!(body) }
  end
  
  # Wunderground returns 200 if your api key is invalid.
  # Not quite sure about best practices,
  # but I have to put the failure case first,
  # due to pattern matching
  def ensure_success({ :ok, %{"response" => %{"error" => error}} }) do
    Logger.error "Error present in response"
    Logger.debug fn -> inspect(error) end
    { :error, error }
  end
  
  def ensure_success({ :ok, body }) do 
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    { :ok, body }
  end
end