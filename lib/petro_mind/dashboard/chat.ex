defmodule PetroMind.Dashboard.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias PetroMind.Dashboard.Report

  schema "chats" do
    field :message, :string
    belongs_to :report, Report

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:message])
    |> validate_required([:message])
    |> assoc_constraint(:report)
  end
end
