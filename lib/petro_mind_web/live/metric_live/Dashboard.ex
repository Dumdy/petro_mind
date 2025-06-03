defmodule PetroMindWeb.MetricLive.Index do
  use PetroMindWeb, :live_view

  alias PetroMind.Dashboard
  alias PetroMind.Dashboard.Metric

  @impl true
  def mount(_params, _session, socket) do
    metrics = Dashboard.list_meterics()

    labels =
      Enum.map(metrics, fn metric ->
        Calendar.strftime(metric.inserted_at, "%b %-d %H:%M")
      end)

    socket =
      socket
      |> stream(:meterics, metrics)
      |> assign(:metrics, metrics)
      |> assign(:labels, labels)
      |> assign(:production_rates, Enum.map(metrics, & &1.production_rate))
      |> assign(:water_cuts, Enum.map(metrics, & &1.water_cut))
      |> assign(:average_flow_rates, Enum.map(metrics, & &1.average_flow_rate))
      |> assign(:down_times, Enum.map(metrics, & &1.down_time))

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Metric")
    |> assign(:metric, Dashboard.get_metric!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Metric")
    |> assign(:metric, %Metric{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Meterics")
    |> assign(:metric, nil)
  end

  def handle_info(:tick, %{assigns: %{metrics: []}} = socket) do
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    metrics = socket.assigns.metrics
    next_index = rem(socket.assigns.current_index + 1, length(metrics))

    {:noreply, assign(socket, :current_index, next_index)}
  end

  @impl true
  def handle_info({PetroMindWeb.MetricLive.FormComponent, {:saved, metric}}, socket) do
    {:noreply, stream_insert(socket, :meterics, metric)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    metric = Dashboard.get_metric!(id)
    {:ok, _} = Dashboard.delete_metric(metric)

    {:noreply, stream_delete(socket, :meterics, metric)}
  end
end
