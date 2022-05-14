defmodule ScdbWeb.RunLive.FormComponent do
  use ScdbWeb, :live_component

  alias Scdb.Mining

  @impl true
  def update(%{run: run} = assigns, socket) do
    changeset = Mining.change_run(run)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"run" => run_params}, socket) do
    changeset =
      socket.assigns.run
      |> Mining.change_run(run_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("miners_changed", %{"run" => run_params}, socket) do
    run_params = make_miners_an_array(run_params)

    changeset =
      socket.assigns.run
      |> Mining.change_run(run_params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"run" => run_params}, socket) do
    run_params = make_miners_an_array(run_params)
    save_run(socket, socket.assigns.action, run_params)
  end

  defp save_run(socket, :edit, run_params) do
    case Mining.update_run(socket.assigns.run, run_params) do
      {:ok, _run} ->
        {:noreply,
         socket
         |> put_flash(:info, "Run updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_run(socket, :new, run_params) do
    case Mining.create_run(run_params) do
      {:ok, _run} ->
        {:noreply,
         socket
         |> put_flash(:info, "Run created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp make_miners_an_array(run_params) do
    array =
      run_params["miners"]
      |> String.split([",", " ", "\n"], trim: true)
    %{run_params | "miners" => array}
  end
end
