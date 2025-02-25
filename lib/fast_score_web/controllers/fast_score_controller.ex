defmodule FastScoreWeb.FastScoreController do
  use FastScoreWeb, :controller

  alias FastScore.Api, as: FootballDataApi
  alias HTTPoison
  alias Poison

  def index(conn, _params) do
    data = FootballDataApi.fetch_api_competition_data()

    render(conn, :index, data: data)
  end

  def render_competition_matchday(conn, _params) do
    render(conn, :match_day)
  end
end
