defmodule AppWeb.AvatarSelection do
  use AppWeb, :live_view
  alias App.Avatars
  alias App.Accounts
  import AppWeb.CustomComponents
  alias Integer

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    avatar_id_changeset = Accounts.change_user_avatar(user)

    socket = assign(socket, avatars: Avatars.list_avatars, current_avatar_id: user.avatar_id, selected_avatar_id: user.avatar_id, avatar_form: to_form(avatar_id_changeset))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Avatars</h1>

    <%= for avatar <- @avatars do %>
      <%= if @selected_avatar_id == avatar.id do %>
        <button disabled>
          <.avatar src={avatar.image} class="w-20 h-20" rarity={avatar.rarity}  />
        </button>
      <% else %>
        <button phx-click="change" phx-value-avatar_id={avatar.id}>
          <.avatar src={avatar.image} rarity={avatar.rarity} class="opacity-30 hover:opacity-100 w-20 h-20" />
        </button>
      <% end %>
    <% end %>

    <.simple_form for={@avatar_form} phx-submit="update_avatar">
      <%= if @current_avatar_id != @selected_avatar_id do %>
        <.input field={@avatar_form[:avatar_id]} type="text" value={@selected_avatar_id} readonly required />
        <.button phx-disable-with="Changing" class="w-full">
          Change Avatar
        </.button>
      <% else %>
        <.button disabled class="w-full">
          Change Avatar
        </.button>
      <% end %>
    </.simple_form>
    """
  end

  def handle_event("change", %{"avatar_id" => avatar_id}, socket) do
    socket = assign(socket, selected_avatar_id: String.to_integer(avatar_id))
    {:noreply, socket}
  end

  def handle_event("update_avatar", _params, socket) do
    user = socket.assigns.current_user
    selected_avatar_id = socket.assigns.selected_avatar_id

    case Accounts.update_user(user, %{avatar_id: selected_avatar_id}) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> redirect(to: ~p"/")
         |> put_flash(:info, "Avatar updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, :avatar_form, to_form(changeset))
        {:noreply, socket}
    end
  end
end
