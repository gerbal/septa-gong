defmodule SeptaGong.Repo do
  use Ecto.Repo,
    otp_app: :septa_gong,
    adapter: Ecto.Adapters.Postgres
end
