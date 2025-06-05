defmodule PetroMind.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :message, :string
      add :metric_id, references(:meterics, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:chats, [:metric_id])
  end
end
