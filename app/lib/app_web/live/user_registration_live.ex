defmodule AppWeb.UserRegistrationLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents

  alias App.Accounts
  alias App.Accounts.User

  def render(assigns) do
    ~H"""
    <.logged_out_nav/>
    <div class="mx-auto max-w-sm">
      <.header class="text-center pt-10">
        <span class="text-2xl">Register for an accounts</span>
        <:subtitle>
          Already registered?
          <.link navigate={~p"/users/log_in"} class="font-semibold text-blue-700 hover:underline">
            Sign in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=registered"}
        method="post"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <.input field={@form[:username]} type="text" label="Username" required />
        <.input field={@form[:password]} type="password" label="Password" required />
        <.input field={@form[:type]} type="select" label="Account Type" required
          options={[{"Student", "student"}, {"Teacher", "teacher"}]}>
        </.input>

        <.input :if={@form[:type].value == "teacher"} field={@form[:join_code]} type="text" label="Class Join Code" required/>

        <.input :if={@form[:type].value == "student"} field={@form[:cash]} style={"display: none;"} type="number" value={500} readonly required/>
        <.input :if={@form[:type].value == "student"} field={@form[:avatar_id]} style={"display: none;"} type="text" required value={"1"} />

        <:actions>
          <.button phx-disable-with="Creating account..." class="w-full mt-3">Create an account</.button>
        </:actions>
      </.simple_form>
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
