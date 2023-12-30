defmodule AppWeb.LeaderboardLive do
  use AppWeb, :live_view
  alias App.Accounts

  def mount(_params, _session, socket) do
    current_class = socket.assigns.current_user.class
    students = Accounts.list_students_in_class(current_class)
    {:ok, assign(socket, current_class: current_class, students: students)}
  end

  def render(assigns) do
    ~H"""
    <.table id="students" rows={@students}>
      <:col :let={student} class="font-bold" label="username"><%= student.username %></:col>
      <:col :let={student} label="cash"><%= student.cash %></:col>
    </.table>
    """
  end
end
