defmodule AppWeb.AvatarSelection do
  use AppWeb, :live_view
  alias App.Avatars
  alias App.Accounts

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    avatar_changeset = Accounts.change_user_avatar(user)

    socket = assign(socket, avatars: Avatars.list_avatars, current_avatar: user.avatar, selected_avatar: user.avatar, avatar_form: to_form(avatar_changeset))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Avatars</h1>

    <%= for avatar <- @avatars do %>
      <%= if @selected_avatar == avatar.image do %>
        <button disabled>
          <img class="rounded-full w-20 h-20 border-solid" src={avatar.image} />
        </button>
      <% else %>
        <button phx-click="change" phx-value-avatar={avatar.image}>
          <img class="rounded-full w-20 h-20 border-solid opacity-30 hover:opacity-100" src={avatar.image} />
        </button>
      <% end %>
    <% end %>

    <.simple_form for={@avatar_form} phx-submit="update_avatar">
      <%= if @current_avatar != @selected_avatar do %>
        <.input field={@avatar_form[:avatar]} type="text" value={@selected_avatar} readonly required />
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

  def handle_event("change", %{"avatar" => avatar}, socket) do
    socket = assign(socket, selected_avatar: avatar)

    {:noreply, socket}
  end

  def handle_event("update_avatar", _params, socket) do
    user = socket.assigns.current_user
    selected_avatar = socket.assigns.selected_avatar

    case Accounts.update_user(user, %{avatar: selected_avatar}) do
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
