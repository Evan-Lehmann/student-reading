defmodule AppWeb.AvatarSelection do
  use AppWeb, :live_view
  alias App.Avatars

  def mount(_params, _session, socket) do
    socket = assign(socket, avatars: Avatars.list_avatars)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <img :for={avatar <- @avatars} class="rounded-full w-20 h-20 border-solid" src={avatar.image} />



    """
  end
end
