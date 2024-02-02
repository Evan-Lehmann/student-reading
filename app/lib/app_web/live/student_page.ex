defmodule AppWeb.StudentPage do
  use AppWeb, :live_view
  alias App.Accounts
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <main class="d-flex flex-nowrap">
      <.teacher_sidebar active_tab="rewards">
      </.teacher_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
        <h2 class="h1 mb-3 mt-3 text-center">Manage Student</h2>
      </div>

    </main>
    """
  end
end
