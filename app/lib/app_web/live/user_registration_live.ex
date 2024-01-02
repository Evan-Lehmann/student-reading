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
      <.header class="text-center mb-3">
        Register for an account
        <:subtitle>
          Already registered?
          <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
            Sign in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <div class="card px-5 py-4">
        <.simple_form
          for={@form}
          id="registration_form"
          phx-submit="save"
          phx-change="validate"
          phx-trigger-action={@trigger_submit}
          action={~p"/users/log_in?_action=registered"}
          method="post"
        >


          <.input field={@form[:username]} type="text" label="Username" required class="mb-3"  />
          <.input field={@form[:password]} type="password" label="Password" required class="mb-3" />
          <.input field={@form[:type]} type="select" label="Account Type" class="mb-3" required
            options={[{"Student", "student"}, {"Teacher", "teacher"}]}>
          </.input>
          <.input :if={@form[:type].value == "teacher"} field={@form[:join_code]} type="text" label="Class Join Code" required class="mb-3" />
          <.input :if={@form[:type].value == "student"} field={@form[:avatar_id]}  type="select" label="Avatar" required class="mb-3"
            options={[{"Astronaut", "1"}, {"Alien", "2"}]}>
          </.input>
          <.input :if={@form[:type].value == "student"} field={@form[:cash]} type="number" value={500} readonly required class="d-none"/>



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
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
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
