defmodule IncidentMap2Web.IncidentControllerTest do
  use IncidentMap2Web.ConnCase

  alias IncidentMap2.Incidents

  @create_attrs %{description: "some description", lat: 120.5, lng: 120.5}
  @update_attrs %{description: "some updated description", lat: 456.7, lng: 456.7}
  @invalid_attrs %{description: nil, lat: nil, lng: nil}

  def fixture(:incident) do
    {:ok, incident} = Incidents.create_incident(@create_attrs)
    incident
  end

  describe "index" do
    test "lists all incidents", %{conn: conn} do
      conn = get(conn, Routes.incident_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Incidents"
    end
  end

  describe "new incident" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.incident_path(conn, :new))
      assert html_response(conn, 200) =~ "New Incident"
    end
  end

  describe "create incident" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.incident_path(conn, :create), incident: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.incident_path(conn, :show, id)

      conn = get(conn, Routes.incident_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Incident"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.incident_path(conn, :create), incident: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Incident"
    end
  end

  describe "edit incident" do
    setup [:create_incident]

    test "renders form for editing chosen incident", %{conn: conn, incident: incident} do
      conn = get(conn, Routes.incident_path(conn, :edit, incident))
      assert html_response(conn, 200) =~ "Edit Incident"
    end
  end

  describe "update incident" do
    setup [:create_incident]

    test "redirects when data is valid", %{conn: conn, incident: incident} do
      conn = put(conn, Routes.incident_path(conn, :update, incident), incident: @update_attrs)
      assert redirected_to(conn) == Routes.incident_path(conn, :show, incident)

      conn = get(conn, Routes.incident_path(conn, :show, incident))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, incident: incident} do
      conn = put(conn, Routes.incident_path(conn, :update, incident), incident: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Incident"
    end
  end

  describe "delete incident" do
    setup [:create_incident]

    test "deletes chosen incident", %{conn: conn, incident: incident} do
      conn = delete(conn, Routes.incident_path(conn, :delete, incident))
      assert redirected_to(conn) == Routes.incident_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.incident_path(conn, :show, incident))
      end
    end
  end

  defp create_incident(_) do
    incident = fixture(:incident)
    %{incident: incident}
  end
end
