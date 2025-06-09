defmodule PetroMindWeb.ReportLive.FormComponent do
  use PetroMindWeb, :live_component



  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage report records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="report-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:value]} type="text" label="Value" />
        <.input field={@form[:T]} type="text" label="T" />
        <.input field={@form[:threshold]} type="text" label="Threshold" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Report</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  # defp save_report(socket, :edit, report_params) do
  #   case Dashboard.update_report(socket.assigns.report, report_params) do
  #     {:ok, report} ->
  #       notify_parent({:saved, report})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Report updated successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, form: to_form(changeset))}
  #   end
  # end

  # defp save_report(socket, :new, report_params) do
  #   case Dashboard.create_report(report_params) do
  #     {:ok, report} ->
  #       notify_parent({:saved, report})

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Report created successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, form: to_form(changeset))}
  #   end
  # end

end
