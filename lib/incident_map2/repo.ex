defmodule IncidentMap2.Repo do
  use Ecto.Repo,
    otp_app: :incident_map2,
    adapter: Ecto.Adapters.Postgres
end
