defmodule FastScore.Api do
  alias HTTPoison
  alias Poison

  def fetch_api_competition_data() do
    api_url = "https://api.football-data.org/v4/competitions"

    # Fetch the API key from the configuration
    case Application.fetch_env!(:fast_score, :api_key) do
      api_key when is_binary(api_key) ->
        # Make the GET request to the API
        case HTTPoison.get(api_url, [{"X-Auth-Token", api_key}]) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            body
            |> Poison.decode!()
            |> filter_competitions_data()

          {:ok, %HTTPoison.Response{status_code: status_code}} ->
            IO.puts("Failed with status code: #{status_code}")

          {:error, %HTTPoison.Error{reason: reason}} ->
            IO.puts("Error: #{reason}")
        end
    end
  end

  def filter_competitions_data(data) do
    top_five_leagues = ["PL", "BL1", "SA", "PD", "FL1"]

    Enum.filter(data["competitions"], fn competition ->
      competition["code"] in top_five_leagues
    end)
  end
end
