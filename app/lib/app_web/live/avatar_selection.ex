defmodule AppWeb.AvatarSelection do
  use AppWeb, :live_view
  alias App.Avatars

  def mount(_params, _session, socket) do
    socket = assign(socket, astronaut: Avatars.get_avatar!(1), alien: Avatars.get_avatar!(2))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <img class="rounded-full w-20 h-20" src={@astronaut.image} />
    <br>
    <img class="rounded-full w-20 h-20 opacity-50" src={@alien.image} />


    """
  end
end
