defmodule PetroMind.Repo do
  use Ecto.Repo,
    otp_app: :petro_mind,
    adapter: Ecto.Adapters.Postgres
end
