defmodule ScdbWeb.RunLive.Index do
  use ScdbWeb, :live_view

  alias Scdb.Mining
  alias Scdb.Mining.Run

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :runs, list_runs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Run")
    |> assign(:run, Mining.get_run!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Run")
    |> assign(:run, %Run{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Runs")
    |> assign(:run, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    run = Mining.get_run!(id)
    {:ok, _} = Mining.delete_run(run)

    {:noreply, assign(socket, :runs, list_runs())}
  end

  defp list_runs do
    Mining.list_runs()
  end
end
