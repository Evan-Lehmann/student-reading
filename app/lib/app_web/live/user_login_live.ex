defmodule AppWeb.UserLoginLive do
  use AppWeb, :live_view

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
        Sign in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <div class="px-5 py-2">
        <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
          <.input field={@form[:username]} type="text" label="Username" required class="mb-3" style={"width: 350px;"}/>
          <.input field={@form[:password]} type="password" label="Password" required class="mb-3" />

          <:actions>
            <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" class="mb-3" />
          </:actions>
          <:actions>
            <.button phx-disable-with="Signing in..." class="w-full mb-3">
              Sign in <span aria-hidden="true">→</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    #email = live_flash(socket.assigns.flash, :email)
    #form = to_form(%{"email" => email}, as: "user")
    form = to_form(%{}, as: "user")

    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
