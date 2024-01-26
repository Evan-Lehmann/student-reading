defmodule AppWeb.SettingsLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Avatars
  alias App.Accounts

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    if user.type == "teacher" do
      {:ok, assign(socket, user: user)}
    else
      class_changeset = Accounts.change_user_class(user)
      class_form = to_form(class_changeset)

      code_form = to_form(%{}, as: "user")
      current_class = user.class

      {:ok, assign(socket, code_form: code_form, class_form: class_form, user: user, current_class: current_class, class: nil)}
    end
  end

  def render(assigns) do
    ~H"""
    <%= if @user.type == "teacher" do %>
      <main class="d-flex flex-nowrap">
        <.teacher_sidebar active_tab="settings">
        </.teacher_sidebar>


        <div class="d-flex col justify-content-center py-5">
          <div class="flex-row">
            <div class="flex-col">
            <.header class="text-center">
                Settings
              </.header>
            <br>

            <div>
              <ul class="text-start p-0 m-0">
                <li class="mb-2">
                  Name: <span class="fw-semibold"><%= @current_user.username %></span>
                </li>
                <li class="mb-2">
                  Account Type: <span class="fw-semibold"><%= @current_user.type %></span>
                </li>
                <li class="mb-2">
                  Join Code: <span class="fw-semibold"><%= @current_user.join_code %></span>
                </li>
              </ul>
            </div>

            </div>
            <div class="flex-col">
            </div>
          </div>
        </div>
      </main>
    <% else %>

      <main class="d-flex flex-nowrap text-center">
        <.student_sidebar active_tab="settings">
        </.student_sidebar>

        <div class="d-flex col justify-content-center py-5">
          <div class="flex-row">
            <div class="flex-col">
              <.header class="text-center">
                Settings
              </.header>
              <br>

              <div>
                <ul class="text-start p-0 m-0">
                  <li class="mb-2">
                    Name: <span class="fw-semibold"><%= @current_user.username %></span>
                  </li>
                  <li class="mb-2">
                    Account Type: <span class="fw-semibold"><%= @current_user.type %></span>
                  </li>
                  <li class="mb-2" :if={@current_user.class != nil}>
                    Teacher: <span class="fw-semibold"><%= @current_user.class %></span>
                  </li>
                  <li class="mb-2" :if={@current_user.class == nil}>
                    Teacher:
                  </li>
                </ul>
              </div>

            </div>
            <div class="flex-col">
            </div>
          </div>
        </div>
      </main>

    <% end %>
    """
  end

  def handle_event("check", %{"user" => %{"code" => code}}, socket) do
    class = Accounts.get_teacher_name_by_join_code(code)
    IO.inspect(class)

    {:noreply, assign(socket, class: class)}
  end

  def handle_event("change", %{"user" => %{"class" => class}}, socket) do
    case Accounts.update_user_class(socket.assigns.current_user, %{class: class}) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> redirect(to: ~p"/")
         |> put_flash(:info, "Class updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, class_form: to_form(changeset))
        {:noreply, socket}
    end
  end
end
