defmodule IncidentMap2Web.PageController do
  use IncidentMap2Web, :controller

  alias IncidentMap2.Incidents

  def index(conn, _params) do
    incidents = Incidents.list_incidents()
    render(conn, "index.html", incidents: incidents)
  end
end
