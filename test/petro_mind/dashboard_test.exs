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

  describe "reports" do
    alias PetroMind.Dashboard.Report

    import PetroMind.DashboardFixtures

    @invalid_attrs %{status: nil, value: nil, metric: nil, threshold: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Dashboard.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Dashboard.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{status: "some status", value: "some value", metric: "some metric", threshold: "some threshold"}

      assert {:ok, %Report{} = report} = Dashboard.create_report(valid_attrs)
      assert report.status == "some status"
      assert report.value == "some value"
      assert report.metric == "some metric"
      assert report.threshold == "some threshold"
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{status: "some updated status", value: "some updated value", metric: "some updated metric", threshold: "some updated threshold"}

      assert {:ok, %Report{} = report} = Dashboard.update_report(report, update_attrs)
      assert report.status == "some updated status"
      assert report.value == "some updated value"
      assert report.metric == "some updated metric"
      assert report.threshold == "some updated threshold"
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_report(report, @invalid_attrs)
      assert report == Dashboard.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Dashboard.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_report(report)
    end
  end

  describe "reports" do
    alias PetroMind.Dashboard.Report

    import PetroMind.DashboardFixtures

    @invalid_attrs %{status: nil, value: nil, metric_name: nil, threshold: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Dashboard.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Dashboard.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{status: "some status", value: "some value", metric_name: "some metric_name", threshold: "some threshold"}

      assert {:ok, %Report{} = report} = Dashboard.create_report(valid_attrs)
      assert report.status == "some status"
      assert report.value == "some value"
      assert report.metric_name == "some metric_name"
      assert report.threshold == "some threshold"
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{status: "some updated status", value: "some updated value", metric_name: "some updated metric_name", threshold: "some updated threshold"}

      assert {:ok, %Report{} = report} = Dashboard.update_report(report, update_attrs)
      assert report.status == "some updated status"
      assert report.value == "some updated value"
      assert report.metric_name == "some updated metric_name"
      assert report.threshold == "some updated threshold"
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_report(report, @invalid_attrs)
      assert report == Dashboard.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Dashboard.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_report(report)
    end
  end

  describe "reports" do
    alias PetroMind.Dashboard.Report

    import PetroMind.DashboardFixtures

    @invalid_attrs %{name: nil, status: nil, value: nil, T: nil, threshold: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Dashboard.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Dashboard.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{name: "some name", status: "some status", value: "some value", T: "some T", threshold: "some threshold"}

      assert {:ok, %Report{} = report} = Dashboard.create_report(valid_attrs)
      assert report.name == "some name"
      assert report.status == "some status"
      assert report.value == "some value"
      assert report.T == "some T"
      assert report.threshold == "some threshold"
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", value: "some updated value", T: "some updated T", threshold: "some updated threshold"}

      assert {:ok, %Report{} = report} = Dashboard.update_report(report, update_attrs)
      assert report.name == "some updated name"
      assert report.status == "some updated status"
      assert report.value == "some updated value"
      assert report.T == "some updated T"
      assert report.threshold == "some updated threshold"
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_report(report, @invalid_attrs)
      assert report == Dashboard.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Dashboard.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_report(report)
    end
  end

  describe "chats" do
    alias PetroMind.Dashboard.Chat

    import PetroMind.DashboardFixtures

    @invalid_attrs %{message: nil}

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert Dashboard.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Dashboard.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      valid_attrs = %{message: "some message"}

      assert {:ok, %Chat{} = chat} = Dashboard.create_chat(valid_attrs)
      assert chat.message == "some message"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      update_attrs = %{message: "some updated message"}

      assert {:ok, %Chat{} = chat} = Dashboard.update_chat(chat, update_attrs)
      assert chat.message == "some updated message"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_chat(chat, @invalid_attrs)
      assert chat == Dashboard.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Dashboard.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_chat(chat)
    end
  end
end
