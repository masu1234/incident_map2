defmodule IncidentMap2Web.IncidentMap2Controller do
  use IncidentMap2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
