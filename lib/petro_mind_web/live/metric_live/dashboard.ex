defmodule PetroMindWeb.MetricLive.Index do
  use PetroMindWeb, :live_view

  alias PetroMind.Dashboard
  alias PetroMind.Dashboard.Metric

  @impl true
  def mount(_params, _session, socket) do
    all_metrics = PetroMind.Dashboard.list_all_metrics()

    socket =
      assign(socket,
        all_metrics: all_metrics,
        metrics: Enum.take(all_metrics, 3),
        current_index: 0
      )

    # Rotate every 5 seconds
    Process.send_after(self(), :next_metrics, 5000)

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

  @impl true
  def handle_info(:next_metrics, socket) do
    all_metrics = socket.assigns.all_metrics
    current_index = socket.assigns.current_index
    total = length(all_metrics)

    # Move to next chunk of 3
    next_index = rem(current_index + 3, total)

    metrics_to_show =
      all_metrics
      # allow wrapping around
      |> Enum.concat(all_metrics)
      |> Enum.slice(next_index, 3)

    # Reschedule the timer
    Process.send_after(self(), :next_metrics, 5000)

    {:noreply,
     assign(socket,
       metrics: metrics_to_show,
       current_index: next_index
     )}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    metric = Dashboard.get_metric!(id)
    {:ok, _} = Dashboard.delete_metric(metric)

    {:noreply, stream_delete(socket, :meterics, metric)}
  end
end
