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
        |> filter_competitions_data()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("404 Not Found")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Error: #{reason}")
    end
  end

  def filter_competitions_data(data) do
    top_five_leagues = ["PL", "BL1", "SA", "PD", "FL1"]

    Enum.filter(data["competitions"], fn competition ->
      competition["code"] in top_five_leagues
    end)
  end
end
