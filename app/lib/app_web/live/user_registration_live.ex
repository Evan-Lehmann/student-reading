defmodule AppWeb.UserRegistrationLive do
  use AppWeb, :live_view

  alias App.Accounts
  alias App.Accounts.User

  def render(assigns) do
    ~H"""
    <div id="navbar" class="container">
      <nav class="navbar navbar-expand-lg rounded">
          <div class="container-fluid">
          <a class="navbar-brand" draggable="false" href={~p"/"}>
              <img draggable="false" src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
          </a>
          </div>
      </nav>
    </div>
    <hr id="line">

    <div class="d-flex flex-column justify-content-center align-items-center py-5">
      <.header class="text-center">
        Register for an account
        <:subtitle>
          Already registered?
          <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
            Sign in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <div class="px-5 py-3">
        <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=registered"}
        method="post"
        >
          <.input field={@form[:username]} type="text" label="Username" required class="mb-3"  style={"width: 350px;"}/>
          <.input field={@form[:password]} type="password" label="Password" required class="mb-3" autocomplete="off"/>
          <.input field={@form[:type]} type="text" label="Account Type" value={@type_selected} class="mb-3 d-none" required readonly autocomplete="off"/>
          <div class="mb-3">
            <button :if={@type_selected=="student"} class="btn btn-secondary">Student</button>
            <button :if={@type_selected != "student"} phx-click="select" phx-value-type={"student"} class="btn btn-outline-secondary">Student</button>

            <button :if={@type_selected=="teacher"} class="btn btn-secondary">Teacher</button>
            <button :if={@type_selected != "teacher"} phx-click="select" phx-value-type={"teacher"} class="btn btn-outline-secondary">Teacher</button>
          </div>
          <.input :if={@type_selected == "teacher"} field={@form[:join_code]} type="text" label="Class Join Code" required class="mb-3"/>
          <.input :if={@type_selected == "student"} field={@form[:avatar_id]}  type="text" value={"1"} label="Avatar" required class="d-none"/>
          <.input :if={@type_selected == "student"} field={@form[:cash]} type="number" value={500} readonly required class="d-none"/>
          <:actions>
            <.button phx-disable-with="Creating account..." class="w-full">Create an account</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false, type_selected: "none")
      |> assign_form(changeset)

    {:ok, socket}
  end

  def handle_event("select", %{"type" => type}, socket) do
    {:noreply, assign(socket, type_selected: type)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
