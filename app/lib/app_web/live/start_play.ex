defmodule AppWeb.StartPlay do
  use AppWeb, :live_view
  import AppWeb.CustomComponents


  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <main class="d-flex flex-nowrap ">
      <.student_sidebar active_tab="play"></.student_sidebar>
      <div class="flex-grow-1 d-flex flex-column align-items-center py-4 overflow-scroll">
        <h1 class="h1 mb-3 mt-3 text-center">Play</h1>


        <div class="card mb-3 shadow" style={"width:354px;"} >
          <div class="card-header">
            <span class="bg-points text-points rounded-full px-2 font-medium leading-6 ">
              Easy
            </span>
          </div>
          <div class="card-body">
            <h5 class="card-title">Multiple Choice</h5>
            <a href={~p"/play/easy"} class="btn btn-outline-dark">Start</a>
          </div>
        </div>


        <div class="card mt-3 shadow" style={"width:354px;"} >
          <div class="card-header">
            <span class="bg-medium text-medium rounded-full px-2 font-medium leading-6 ">
              Medium
            </span>
          </div>
          <div class="card-body">
            <h5 class="card-title">Typing 🔥</h5>
            <a  href={~p"/play/medium"} class="btn btn-outline-dark">Start</a>
          </div>
        </div>



      </div>
    </main>
    """
  end
end
