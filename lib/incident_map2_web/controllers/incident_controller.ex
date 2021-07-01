defmodule IncidentMap2Web.IncidentController do
  use IncidentMap2Web, :controller

  alias IncidentMap2.Incidents
  alias IncidentMap2.Incidents.Incident

  def index(conn, _params) do
    incidents = Incidents.list_incidents()
    render(conn, "index.html", incidents: incidents)
  end

  def new(conn, _params) do
    changeset = Incidents.change_incident(%Incident{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"incident" => incident_params}) do
    case Incidents.create_incident(incident_params) do
      {:ok, incident} ->
        conn
        |> put_flash(:info, "Incident created successfully.")
        |> redirect(to: Routes.incident_path(conn, :show, incident))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    incident = Incidents.get_incident!(id)
    render(conn, "show.html", incident: incident)
  end

  def edit(conn, %{"id" => id}) do
    incident = Incidents.get_incident!(id)
    changeset = Incidents.change_incident(incident)
    render(conn, "edit.html", incident: incident, changeset: changeset)
  end

  def update(conn, %{"id" => id, "incident" => incident_params}) do
    incident = Incidents.get_incident!(id)

    case Incidents.update_incident(incident, incident_params) do
      {:ok, incident} ->
        conn
        |> put_flash(:info, "Incident updated successfully.")
        |> redirect(to: Routes.incident_path(conn, :show, incident))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", incident: incident, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    incident = Incidents.get_incident!(id)
    {:ok, _incident} = Incidents.delete_incident(incident)

    conn
    |> put_flash(:info, "Incident deleted successfully.")
    |> redirect(to: Routes.incident_path(conn, :index))
  end
end
