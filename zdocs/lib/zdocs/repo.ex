defmodule Zdocs.Repo do
  use Ecto.Repo,
    otp_app: :zdocs,
    adapter: Ecto.Adapters.Postgres
end
