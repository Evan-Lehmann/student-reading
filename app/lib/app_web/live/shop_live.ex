defmodule AppWeb.ShopLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Avatars
  alias App.Accounts
  alias App.Rewards
  alias App.Rewards.Reward

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    if user.type == "student" do
      {:ok, assign(socket, new_avatar: nil, locked_avatars_ids: Avatars.list_users_locked_avatars(user.id))}
    else
      changeset = Rewards.change_reward(%Reward{})
      {:ok, socket |> assign(check_errors: false, rewards: Rewards.get_rewards_of_teacher(user.id)) |> assign_form(changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <%= if @current_user.type == "student" do %>
      <main class="d-flex flex-nowrap">
        <.student_sidebar active_tab="shop">
        </.student_sidebar>

        <div class="d-flex col justify-content-center py-5">
          <div class="flex-row">
            <div class="flex-col">
              <.header class="text-center">
                Shop
              </.header>

              <p class="text-xl font-bold">Cost: $500</p>
              <p>Your Balance:
                <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                  $<%= @current_user.cash %>
                </span>
              </p>
              <br>
              <br>
            </div>
          </div>
        </div>
      </main>

      <%= if @new_avatar != nil do %>
        <.button disabled class="opacity-50">Unlock Random Avatar</.button>
      <% else %>
        <%= if @current_user.cash < 500 do %>
          <span class="text-red-700">Insufficient Funds!</span>
          <.button disabled class="opacity-50">Unlock Random Avatar</.button>
        <% else %>
          <%= if length(@locked_avatars_ids) <= 0 do %>
            <span class="text-teal-700">You have unlocked all avatars!</span>
            <.button disabled class="opacity-50">Unlock Random Avatar</.button>
          <% else %>
            <.button phx-click="unlock">Unlock Random Avatar</.button>
          <% end %>
        <% end %>
      <% end %>

      <%= if @new_avatar != nil do %>
        <.avatar src={@new_avatar.image} class="w-20 h-20" rarity={@new_avatar.rarity} />
        <.button phx-click="accept">Ok</.button>
      <% end %>
    <% else %>

      <main class="d-flex flex-nowrap">
        <.teacher_sidebar active_tab="rewards">
        </.teacher_sidebar>

        <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
          <h2 class="h1 mb-2 mt-3 text-center">Manage Shop</h2>

          <div class="mt-2 text-start">
            <button data-bs-toggle="modal" data-bs-target="#exampleModal" class="btn mb-2 btn-outline-primary">Create New Item</button>
            <button data-bs-toggle="modal" data-bs-target="#infoModal" class="btn mb-2 btn-outline-secondary">Learn About Point System</button>
          </div>

          <!-- New Item Modal -->
          <div class="modal fade" id="exampleModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  ...
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button type="button" class="btn btn-primary">Save changes</button>
                </div>
              </div>
            </div>
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
                  <p class="leading">On average, it takes ___ hours to reach ___ points.  <br> <br> On average, students play ___ hours a week.  <br> <br> Thus, on average, it takes ___ weeks for a study to reach ___ points.</p>
                </div>
              </div>
            </div>
          </div>


          <table class="content-table shadow-lg">
            <thead>
              <tr>
                <th></th>
                <th>Item</th>
                <th>Price</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><image class="mx-auto d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={"/images/chips.png"} /></td>
                <td>Chips</td>
                <td>
                  <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                    $1000
                  </span>
                </td>
                <td><button class="btn btn-outline-danger disabled">Remove</button></td>
              </tr>
              <tr>
                <td><image class="mx-auto d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={"/images/popcorn.png"} /></td>
                <td>Popcorn</td>
                <td>
                  <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                    $1500
                  </span>
                </td>
                <td><button class="btn btn-outline-danger disabled">Remove</button></td>
              </tr>
              <tr>
                <td><image class="mx-auto d-none d-md-block" style={"width: 46px;height:46px;min-width:46px;"} src={"/images/cup.png"} /></td>
                <td>New Avatar</td>
                <td>
                  <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                    $2500
                  </span>
                </td>
                <td><button class="btn btn-outline-danger disabled">Remove</button></td>
              </tr>
            </tbody>
          </table>

        </div>
      </main>
    <% end %>
    """
  end

  def handle_event("save", %{"reward" => reward_params}, socket) do
    case Rewards.create_reward(reward_params) do
      {:ok, _} ->
        changeset = Rewards.change_reward(%Reward{})
        {:noreply, socket |> assign(rewards: Rewards.get_rewards_of_teacher(socket.assigns.current_user.id)) |> push_event("js-exec", %{to: "#confirm-modal", attr: "data-cancel"}) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end

  def handle_info({:reward_crated, item}, socket) do
    {:noreply, push_event(socket, "highlight", %{id: "item-#{item.id}"})}
  end

  def handle_event("remove", %{"reward_id" => reward_id}, socket) do
    case Rewards.delete_reward_by_id(String.to_integer(reward_id)) do
      {:ok, _} ->
        {:noreply, assign(socket, rewards: Rewards.get_rewards_of_teacher(socket.assigns.current_user.id))}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_event("accept", _params, socket) do
    {:noreply, assign(socket, new_avatar: nil)}
  end

  def handle_event("unlock", _params, socket) do
    user = socket.assigns.current_user
    locked_avatars_ids = socket.assigns.locked_avatars_ids

    case Accounts.unlock_avatar(user, locked_avatars_ids) do
      {{:ok, user}, {:ok, avatar_access}} ->
        socket = assign(socket, current_user: user, new_avatar: avatar_access.avatar, locked_avatars_ids: Avatars.list_users_locked_avatars(user.id))
        {:noreply, socket}

      _ ->
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
