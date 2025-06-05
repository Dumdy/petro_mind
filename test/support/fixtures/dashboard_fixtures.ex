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

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        metric: "some metric",
        status: "some status",
        threshold: "some threshold",
        value: "some value"
      })
      |> PetroMind.Dashboard.create_report()

    report
  end



  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        T: "some T",
        name: "some name",
        status: "some status",
        threshold: "some threshold",
        value: "some value"
      })
      |> PetroMind.Dashboard.create_report()

    report
  end

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        message: "some message"
      })
      |> PetroMind.Dashboard.create_chat()

    chat
  end
end
