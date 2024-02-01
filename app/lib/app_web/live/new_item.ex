defmodule AppWeb.NewItem do
  use AppWeb, :live_view
  alias App.Rewards.Reward
  alias App.Rewards
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    changeset = Rewards.change_reward(%Reward{})
    {:ok, socket |> assign(check_errors: false) |> assign_form(changeset)}
  end

  def render(assigns) do
    ~H"""
    <main class="d-flex flex-nowrap">
      <.teacher_sidebar active_tab="rewards">
      </.teacher_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
        <h2 class="h1 mb-2 mt-3 text-center">Manage Shop</h2>
        <.link navigate={~p"/shop"} class="font-semibold text-blue-700">
          <span aria-hidden="true">←</span> Go back
        </.link>

        <.simple_form for={@form} phx-submit="save">
          <.header>New Item</.header>
          <.input field={@form[:name]} type="text" required/>
          <.input field={@form[:price]} type="number" required/>
          <.button>Save</.button>
        </.simple_form>
      </div>
    </main>
    """
  end

  def handle_event("save", %{"reward" => reward_params}, socket) do
    complete_reward_params = reward_params |> Map.put("user_id", socket.assigns.current_user.id) |> Map.put("image", "/images/popcorn.png")
    case Rewards.create_reward(complete_reward_params) do
      {:ok, _} ->
        {:noreply,
           socket
           |> redirect(to: ~p"/shop")
           |> put_flash(:info, "Item created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "reward")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
