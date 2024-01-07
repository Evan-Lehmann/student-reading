defmodule AppWeb.UserLoginLive do
  use AppWeb, :live_view
  import AppWeb.CustomComponents

  def render(assigns) do
    ~H"""
    <.logged_out_nav />
    <div class="mx-auto max-w-sm">
      <.header class="text-center pt-10">
        <span class="text-2xl">Sign in to account</span>
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="font-semibold text-blue-700 hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:username]} type="text" label="Username" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" class="" />
        </:actions>
        <:actions>
          <.button phx-disable-with="Signing in..." class="w-full mt-3">
            Sign in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
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
