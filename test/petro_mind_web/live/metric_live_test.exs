defmodule PetroMindWeb.MetricLiveTest do
  use PetroMindWeb.ConnCase

  import Phoenix.LiveViewTest
  import PetroMind.DashboardFixtures

  @create_attrs %{production_rate: 42, water_cut: 42, down_time: 42}
  @update_attrs %{production_rate: 43, water_cut: 43, down_time: 43}
  @invalid_attrs %{production_rate: nil, water_cut: nil, down_time: nil}

  defp create_metric(_) do
    metric = metric_fixture()
    %{metric: metric}
  end

  describe "Index" do
    setup [:create_metric]

    test "lists all meterics", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/meterics")

      assert html =~ "Listing Meterics"
    end

    test "saves new metric", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/meterics")

      assert index_live |> element("a", "New Metric") |> render_click() =~
               "New Metric"

      assert_patch(index_live, ~p"/meterics/new")

      assert index_live
             |> form("#metric-form", metric: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#metric-form", metric: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/meterics")

      html = render(index_live)
      assert html =~ "Metric created successfully"
    end

    test "updates metric in listing", %{conn: conn, metric: metric} do
      {:ok, index_live, _html} = live(conn, ~p"/meterics")

      assert index_live |> element("#meterics-#{metric.id} a", "Edit") |> render_click() =~
               "Edit Metric"

      assert_patch(index_live, ~p"/meterics/#{metric}/edit")

      assert index_live
             |> form("#metric-form", metric: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#metric-form", metric: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/meterics")

      html = render(index_live)
      assert html =~ "Metric updated successfully"
    end

    test "deletes metric in listing", %{conn: conn, metric: metric} do
      {:ok, index_live, _html} = live(conn, ~p"/meterics")

      assert index_live |> element("#meterics-#{metric.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#meterics-#{metric.id}")
    end
  end

  describe "Show" do
    setup [:create_metric]

    test "displays metric", %{conn: conn, metric: metric} do
      {:ok, _show_live, html} = live(conn, ~p"/meterics/#{metric}")

      assert html =~ "Show Metric"
    end

    test "updates metric within modal", %{conn: conn, metric: metric} do
      {:ok, show_live, _html} = live(conn, ~p"/meterics/#{metric}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Metric"

      assert_patch(show_live, ~p"/meterics/#{metric}/show/edit")

      assert show_live
             |> form("#metric-form", metric: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#metric-form", metric: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/meterics/#{metric}")

      html = render(show_live)
      assert html =~ "Metric updated successfully"
    end
  end
end
