defmodule AppWeb.ShopLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Accounts
  alias App.Rewards
  alias App.Rewards.Reward

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    if user.type == "student" do
      curr_points = socket.assigns.current_user.points
      {:ok, assign(socket, points: curr_points, last_reward: nil, rewards: Rewards.get_rewards_of_teacher(Accounts.get_teacher_id_by_name(user.class)))}
    else
      changeset = Rewards.change_reward(%Reward{}, %{"user_id" => socket.assigns.current_user.id, "image" => "/images/chips.png"})
      {:ok, socket |> assign(check_errors: false, last_reward: nil, points: nil, rewards: Rewards.get_rewards_of_teacher(user.id)) |> assign_form(changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Show This to Your Teacher</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div :if={is_nil(@last_reward) == false} class="modal-body">
            <ul class="text-start p-0 m-0">
              <li class="mb-2">
                Name: <span class="fw-semibold"><%= @current_user.username %></span>
              </li>
              <li class="mb-2">
                Item: <span class="fw-semibold"><%= Rewards.get_name_by_id(@last_reward) %></span>
              </li>
              <li class="mb-2">
                Price: <span class="fw-semibold"><%= Rewards.get_price_by_id(@last_reward) %></span>
              </li>
              <li class="mb-2">
                Date: <span class="fw-semibold"><%= Date.utc_today().month %>/<%= Date.utc_today().day %>/<%= Date.utc_today().year %></span>
              </li>
            </ul>
            <image class="d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={Rewards.get_image_by_id(@last_reward)} />
          </div>
        </div>
      </div>
    </div>

    <%= if @current_user.type == "student" do %>
      <main class="d-flex flex-nowrap">
        <.student_sidebar active_tab="rewards">
        </.student_sidebar>

        <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
          <h1 class="h1 mb-3 mt-3 text-center">Shop</h1>
          <p class="lead">Your Points: <span class="bg-points text-points rounded-full px-2 font-medium leading-6"><%= @points %></span></p>


          <.bootstrap_table id="rewards" rows={@rewards}>
            <:col :let={reward} >
              <image class="mx-auto d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={reward.image} />
            </:col>
            <:col :let={reward} label="Name"><%= reward.name %></:col>
            <:col :let={reward} label="Points">
              <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                <%= reward.price %>
              </span>
            </:col>
            <:col :let={reward}><button :if={reward.id != nil && reward.price <= @points} phx-click="buy" data-bs-toggle="modal" data-bs-target="#staticBackdrop" phx-value-reward_id={reward.id} class="btn btn-outline-dark">Buy</button></:col>
          </.bootstrap_table>
        </div>
      </main>
    <% else %>

      <main class="d-flex flex-nowrap">
        <.teacher_sidebar active_tab="rewards">
        </.teacher_sidebar>

        <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
          <h1 class="h1 mb-3 mt-3 text-center">Manage Shop</h1>

          <div class="mt-2 text-start">
            <.link href={~p"/shop/new"} class="btn mb-2 btn-outline-primary">Create New Item</.link>
            <button data-bs-toggle="modal" data-bs-target="#infoModal" class="btn mb-2 btn-outline-secondary">Learn About Point System</button>
          </div>

          <!-- infoModal -->
          <div class="modal fade" id="infoModal" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="infoModalLabel">Point System</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <p class="leading">For easy questions, students get <b>+10</b> for correct <br>answers and <b>-10</b> for incorrect answers. <br> <br> For medium questions, students get <b>+25</b> for correct <br> answers and <b>-25</b> for incorrect answers.</p>
                </div>
              </div>
            </div>
          </div>

          <.bootstrap_table id="rewards" rows={@rewards}>
            <:col :let={reward} >
              <image class="mx-auto d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={reward.image} />
            </:col>
            <:col :let={reward} label="Name"><%= reward.name %></:col>
            <:col :let={reward} label="Points">
              <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                <%= reward.price %>
              </span>
            </:col>
            <:col :let={reward}><button :if={reward.id != nil} phx-click="remove" phx-value-reward_id={reward.id} class="btn btn-outline-danger">Remove</button></:col>
          </.bootstrap_table>

        </div>
      </main>
    <% end %>
    """
  end

  def handle_event("buy", %{"reward_id" => reward_id}, socket) do
    price = Rewards.get_price_by_id(reward_id)
    if price <= socket.assigns.points do
      points = socket.assigns.points - price
      Accounts.update_user_points(socket.assigns.current_user, %{"points" => Integer.to_string(points)})
      {:noreply, assign(socket, points: points, last_reward: reward_id)}
    else
      {:noreply, socket}
    end
  end

  def handle_event("remove", %{"reward_id" => reward_id}, socket) do
    case Rewards.delete_reward_by_id(String.to_integer(reward_id)) do
      {:ok, _} ->
        {:noreply, assign(socket, rewards: Rewards.get_rewards_of_teacher(socket.assigns.current_user.id))}

      {:error, _} ->
        {:noreply, socket}
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
