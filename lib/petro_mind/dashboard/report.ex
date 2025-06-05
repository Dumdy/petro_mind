defmodule PetroMind.Dashboard.Report do
  use Ecto.Schema
  import Ecto.Changeset
  alias PetroMind.Dashboard.Metric

  schema "reports" do
    field :report_type, :string
    field :status, :string
    field :value, :string
    field :threshold, :string
    belongs_to :metric, Metric

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:report_type, :value, :threshold, :status])
    |> validate_required([:report_type, :value, :threshold, :status])
    |> unique_constraint([:metric_id, :report_type])
    |> assoc_constraint(:metric)
  end
end
