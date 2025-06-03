defmodule PetroMind.Repo.Migrations.AddFlowRateToMeterics do
  use Ecto.Migration

  def change do
    alter table(:meterics) do
      add :average_flow_rate, :float, virtual: true
    end
  end
end
