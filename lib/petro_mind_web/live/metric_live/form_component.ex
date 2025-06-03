defmodule PetroMindWeb.MetricLive.FormComponent do
  use PetroMindWeb, :live_component

  alias PetroMind.Dashboard

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage metric records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="metric-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:production_rate]} type="number" label="Production rate" />
        <.input field={@form[:water_cut]} type="number" label="Water cut" />
        <.input field={@form[:down_time]} type="number" label="Down time" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Metric</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true

  def handle_event("save", %{"metric" => metric_params}, socket) do
    save_metric(socket, socket.assigns.action, metric_params)
  end

  defp save_metric(socket, :edit, metric_params) do
    case Dashboard.update_metric(socket.assigns.metric, metric_params) do
      {:ok, metric} ->
        notify_parent({:saved, metric})

        {:noreply,
         socket
         |> put_flash(:info, "Metric updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_metric(socket, :new, metric_params) do
    case Dashboard.create_metric(metric_params) do
      {:ok, metric} ->
        notify_parent({:saved, metric})

        {:noreply,
         socket
         |> put_flash(:info, "Metric created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
