defmodule AppWeb.ClassIndexLive do
  use AppWeb, :live_view
  alias App.Accounts
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    if current_user.type == "teacher" do
      students = Accounts.list_students_in_class(current_user.username)
      {:ok, assign(socket, current_user: current_user, students: students)}
    else
      students = Accounts.list_students_in_class(current_user.class)
      {:ok, assign(socket, current_user: current_user, students: students)}
    end
  end

  def render(assigns) do
    ~H"""
    <.table id="students" rows={@students}>
      <:col :let={student}>
        <.avatar src={student.avatar.image} rarity={student.avatar.rarity} class="w-16 h-16" />
      </:col>
      <:col :let={student} label="username"><%= student.username %></:col>
      <:col :let={student} label="cash">
        <p class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
          $<%= student.cash %>
        </p>
      </:col>
      <:col :if={@current_user.type == "teacher"} :let={student}>
        <button class="rounded-lg bg-red-600 px-2 py-1 hover:bg-red-600/80 text-white" phx-click="remove" value={student.id}>
          Delete
        </button>
      </:col>
    </.table>
    """
  end

  def handle_event("remove", %{"value" => student_id}, socket) do
    student = Accounts.get_user!(student_id)
    case Accounts.update_user_class(student, %{class: nil}) do
      {:ok, _user} ->
        students = Accounts.list_students_in_class(socket.assigns.current_user.username)
        socket = assign(socket, students: students)
        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, socket
         |> put_flash(:error, "Something went wrong!")}
    end
  end
end
