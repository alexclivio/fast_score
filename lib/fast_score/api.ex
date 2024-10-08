defmodule FastScore.Api do
  alias HTTPoison
  alias Poison

  def fetch_api_competition_data() do
    # make a GET request to the football-data API
    api_url = "https://api.football-data.org/v4/competitions"
    api_key = Application.get_env(:fast_score, :api_key)

    case HTTPoison.get(api_url, [{"X-Auth-Token", api_key}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()
        |> filter_competition_data()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("404 Not Found")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Error: #{reason}")
    end
  end

  def filter_competition_data(data) do
    data["competitions"]
    |> List.first()
    |> dbg()
  end
end
