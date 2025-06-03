defmodule PetroMind.DashboardTest do
  use PetroMind.DataCase

  alias PetroMind.Dashboard

  describe "meterics" do
    alias PetroMind.Dashboard.Metric

    import PetroMind.DashboardFixtures

    @invalid_attrs %{production_rate: nil, water_cut: nil, down_time: nil}

    test "list_meterics/0 returns all meterics" do
      metric = metric_fixture()
      assert Dashboard.list_meterics() == [metric]
    end

    test "get_metric!/1 returns the metric with given id" do
      metric = metric_fixture()
      assert Dashboard.get_metric!(metric.id) == metric
    end

    test "create_metric/1 with valid data creates a metric" do
      valid_attrs = %{production_rate: 42, water_cut: 42, down_time: 42}

      assert {:ok, %Metric{} = metric} = Dashboard.create_metric(valid_attrs)
      assert metric.production_rate == 42
      assert metric.water_cut == 42
      assert metric.down_time == 42
    end

    test "create_metric/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_metric(@invalid_attrs)
    end

    test "update_metric/2 with valid data updates the metric" do
      metric = metric_fixture()
      update_attrs = %{production_rate: 43, water_cut: 43, down_time: 43}

      assert {:ok, %Metric{} = metric} = Dashboard.update_metric(metric, update_attrs)
      assert metric.production_rate == 43
      assert metric.water_cut == 43
      assert metric.down_time == 43
    end

    test "update_metric/2 with invalid data returns error changeset" do
      metric = metric_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_metric(metric, @invalid_attrs)
      assert metric == Dashboard.get_metric!(metric.id)
    end

    test "delete_metric/1 deletes the metric" do
      metric = metric_fixture()
      assert {:ok, %Metric{}} = Dashboard.delete_metric(metric)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_metric!(metric.id) end
    end

    test "change_metric/1 returns a metric changeset" do
      metric = metric_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_metric(metric)
    end
  end
end
