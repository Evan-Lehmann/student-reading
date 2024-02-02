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

          <div class="d-flex col justify-content-center py-5">
            <div class="flex-row">
              <div class="flex-col">
                <.header class="text-center">
                  Welcome, <%= @current_user.username %>!
                </.header>
                <span>Please enter your class join code</span>
                <.error :if={@check_errors==true}>
                  Oops, something went wrong! Please check the errors below.
                </.error>
              </div>
              <div class="flex-col">
                <.simple_form for={@code_form} phx-submit="check" phx-change="validate">
                  <.input field={@code_form[:code]} type="text" required/>
                  <.button>Check</.button>
                </.simple_form>
              </div>
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
