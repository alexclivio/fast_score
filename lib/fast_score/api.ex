defmodule FastScore.Api do
  alias HTTPoison
  alias Poison

  def fetch_api_competition_data() do
    # make a GET request to the football-data API
    api_url = "https://api.football-data.org/v4/competitions"

    case HTTPoison.get(api_url, [{"X-Auth-Token", "a72c7951c42845dc98338929abba5ec4"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("404 Not Found")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Error: #{reason}")
    end
  end

  def filter_competition_data(data) do
    dbg(data)
  end
end
