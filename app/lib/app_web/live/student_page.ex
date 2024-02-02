defmodule AppWeb.StudentPage do
  use AppWeb, :live_view
  alias App.Accounts
  import AppWeb.CustomComponents

  def mount(%{"name" => name}, _session, socket) do
    {:ok, assign(socket, name: name)}
  end

  def render(assigns) do
    ~H"""
    <main class="d-flex flex-nowrap">
      <.teacher_sidebar active_tab="class">
      </.teacher_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
        <h2 class="h1 mb-3 mt-3 text-center">Manage Class</h2>
        <p class="lead text-muted">Student: <%= @name %></p>
        <.link navigate={~p"/"} class="font-semibold text-blue-700 hover:underline">
            Go Back
          </.link>
      </div>

    </main>
    """
  end
end
