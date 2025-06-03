defmodule PetroMind.Dashboard.Metric do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meterics" do
    field :production_rate, :integer
    field :water_cut, :integer
    field :down_time, :integer
    field :average_flow_rate, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(metric, attrs) do
    metric
    |> cast(attrs, [:production_rate, :water_cut, :down_time, :average_flow_rate])
    |> validate_required([:production_rate, :water_cut, :down_time])
  end
end
