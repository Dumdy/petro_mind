defmodule PetroMind.Repo.Migrations.CreateMeterics do
  use Ecto.Migration

  def change do
    create table(:meterics) do
      add :production_rate, :integer
      add :water_cut, :integer
      add :down_time, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
