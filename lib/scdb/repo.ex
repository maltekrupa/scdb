defmodule Scdb.Repo do
  use Ecto.Repo,
    otp_app: :scdb,
    adapter: Ecto.Adapters.Postgres
end
