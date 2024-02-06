defmodule AppWeb.JoinClass do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Accounts

  def mount(_session, _params, socket) do
    user = socket.assigns.current_user
    class_changeset = Accounts.change_user_class(user)
    code_form = to_form(%{}, as: "user")

    {:ok, assign(socket, code_form: code_form, class: nil, check_errors: nil)}
  end

  def render(assigns) do
    ~H"""
    <main class="d-flex flex-nowrap">
      <.disabled_sidebar>
      </.disabled_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
        <h1 class="h1 mb-3 mt-3 text-center">Welcome, <%= @current_user.username %>!</h1>
        <span class="lead text-muted">Enter Your Class Join Code</span>

        <div style={"width:354px;"}>
          <.simple_form for={@code_form} phx-submit="check" phx-change="validate">
            <.error :if={@check_errors}>
              Class not found! Please double check join code.
            </.error>
            <.input field={@code_form[:code]} type="text" required/>
            <.button class="w-full mt-3">Check</.button>
          </.simple_form>
        </div>
      </div>
    </main>
    """
  end


  def handle_event("check", %{"user" => %{"code" => code}}, socket) do
    class = Accounts.get_teacher_name_by_join_code(code)
    if class == nil do
      code_form = to_form(%{"code" => code}, as: "user")
      {:noreply, assign(socket, code_form: code_form, check_errors: true)}
    else
      case Accounts.update_user_class(socket.assigns.current_user, %{class: class}) do
        {:ok, _user} ->
          {:noreply,
           socket
           |> redirect(to: ~p"/")
           |> put_flash(:info, "Class updated successfully")}

        {:error, %Ecto.Changeset{} = _changeset} ->
          code_form = to_form(%{"code" => code}, as: "user")
          socket = assign(socket, code_form: code_form)
          {:noreply, socket}
      end
    end
  end

  def handle_event("validate", _params, socket) do
    {:noreply, assign(socket, check_errors: nil)}
  end
end
