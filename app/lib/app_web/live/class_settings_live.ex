defmodule AppWeb.ClassSettingsLive do
  use AppWeb, :live_view
  alias App.Accounts

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    class_changeset = Accounts.change_user_class(user)
    class_form = to_form(class_changeset)

    code_form = to_form(%{}, as: "user")
    current_class = user.class

    {:ok, assign(socket, code_form: code_form, class_form: class_form, user: user, current_class: current_class, class: nil)}
  end

  def render(assigns) do
    ~H"""
    <div id="navbar" class="container">
      <nav class="navbar navbar-expand-lg rounded">
          <div class="container-fluid">
          <a class="navbar-brand" draggable="false" href={~p"/"}>
              <img draggable="false" src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
          </a>
          <.link class="btn btn-outline-primary" method="delete" href={~p"/users/log_out"}>Log out</.link>
          </div>
      </nav>
    </div>
    <hr id="line">
    <span class="font-bold text-red-900">Current Class: <%= @current_class %> </span>

    <.simple_form for={@code_form} phx-submit="check" >
      <.input field={@code_form[:code]} type="text" required/>
      <.button>Check</.button>
    </.simple_form>

    <.simple_form for={@class_form} phx-submit="change" >
      <.input field={@class_form[:class]} type="text" value={@class} required readonly/>
      <%= if @class == nil do %>
        <.button class="opacity-50">Submit</.button>
      <% else %>
        <.button>Submit</.button>
      <% end %>
    </.simple_form>
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
