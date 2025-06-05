defmodule PetroMind.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :report_type, :string
      add :value, :string
      add :threshold, :string
      add :status, :string
      add :metric_id, references(:meterics, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:reports, [:metric_id])
    create unique_index(:reports, [:metric_id, :report_type])
  end
end
