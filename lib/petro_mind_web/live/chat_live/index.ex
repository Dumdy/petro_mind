defmodule PetroMindWeb.ChatLive.Index do
  use PetroMindWeb, :live_view

  alias PetroMind.Dashboard
  alias PetroMind.Dashboard.Chat

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:query, "")
     |> assign(:response, nil)
     |> assign(:page_title, "Listing Chats")
     |> assign(:chat, nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Chat")
    |> assign(:chat, Dashboard.get_chat!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Chat")
    |> assign(:chat, %Chat{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Chats")
    |> assign(:chat, nil)
  end

  @impl true
  def handle_info({PetroMindWeb.ChatLive.FormComponent, {:saved, chat}}, socket) do
    {:noreply, stream_insert(socket, :chats, chat)}
  end

  @impl true
  def handle_event("send_search", %{"query" => query}, socket) do
    response = PetroMind.Dashboard.analyze_input(query)

    {:noreply,
     socket
     |> assign(:query, query)
     |> assign(:response, response)}
  end
end
