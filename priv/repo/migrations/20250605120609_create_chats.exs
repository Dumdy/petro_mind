defmodule PetroMind.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :message, :string
      add :report_id, references(:reports, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:chats, [:report_id])
  end
end
