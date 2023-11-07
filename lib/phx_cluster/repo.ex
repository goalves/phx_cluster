defmodule PhxCluster.Repo do
  use Ecto.Repo,
    otp_app: :phx_cluster,
    adapter: Ecto.Adapters.Postgres
end
