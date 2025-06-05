defmodule PetroMindWeb.ReportLive.Index do
  use PetroMindWeb, :live_view

  alias PetroMind.Dashboard
  alias PetroMind.Dashboard.Report

  @impl true
  def mount(_params, _session, socket) do
    reports = list_reports()

    {:ok,
     socket
     |> assign(:reports, reports)
     |> assign(:page_title, "Listing Reports")
     |> assign(:report, nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Report")
    |> assign(:report, Dashboard.get_report!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Report")
    |> assign(:report, %Report{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reports")
    |> assign(:report, nil)
  end

  @impl true
  def handle_info({:report_created, _report}, socket) do
    updated_reports = Enum.map(list_reports(), fn report -> {report.id, report} end)
    {:noreply, assign(socket, :reports, updated_reports)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    report = Dashboard.get_report!(id)
    {:ok, _} = Dashboard.delete_report(report)

    {:noreply, stream_delete(socket, :reports, report)}
  end

  defp list_reports do
    Dashboard.list_reports()
    |> Enum.map(fn report -> {report.id, report} end)
  end
end
