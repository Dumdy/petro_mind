defmodule PetroMind.DashboardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetroMind.Dashboard` context.
  """

  @doc """
  Generate a metric.
  """
  def metric_fixture(attrs \\ %{}) do
    {:ok, metric} =
      attrs
      |> Enum.into(%{
        down_time: 42,
        production_rate: 42,
        water_cut: 42
      })
      |> PetroMind.Dashboard.create_metric()

    metric
  end
end
