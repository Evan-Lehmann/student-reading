defmodule AppWeb.ShopLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Avatars
  alias App.Accounts
  alias App.Rewards

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    if user.type == "student" do
      {:ok, assign(socket, new_avatar: nil, locked_avatars_ids: Avatars.list_users_locked_avatars(user.id))}
    else
      {:ok, assign(socket, rewards: Rewards.get_rewards_of_teacher(user.id))}
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

        <div class="d-flex col justify-content-center py-5">
          <div class="flex-row">
            <div class="flex-col">
              <.header class="text-center font-xl">
                Manage Rewards
              </.header>
            </div>
            <div class="flex-col">
              <div class="card" style="width: 12rem;">
                  <div class="card-body">
                    <h5 class="card-title">New Avatar</h5>
                    <span class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
                      $500
                    </span>
                    <br>
                    <button class="btn btn-primary px-2 py-1" disabled="true">Edit</button>
                    <button class="btn btn-primary px-2 py-1" disabled="true">Delete</button>
                  </div>
                </div>
              </div>
              <p :for={reward <- @rewards}> <%= reward.name %></p>
          </div>
        </div>
      </main>
    <% end %>
    """
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
end
