defmodule FastScoreWeb.FastScoreController do
  use FastScoreWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
