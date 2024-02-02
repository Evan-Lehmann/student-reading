defmodule AppWeb.Practice do
  use AppWeb, :live_view
  alias App.Quiz
  alias App.Accounts
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, word: "the")}
  end

  def render(assigns) do
    ~H"""
      <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
        <symbol id="audio" viewBox="0 0 16 16">
          <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
          <path d="M6.271 5.055a.5.5 0 0 1 .52.038l3.5 2.5a.5.5 0 0 1 0 .814l-3.5 2.5A.5.5 0 0 1 6 10.5v-5a.5.5 0 0 1 .271-.445"/>
        </symbol>
      </svg>

      <main class="d-flex flex-nowrap">
        <.student_sidebar active_tab="class"></.student_sidebar>

        <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
          <!-- Welcome Header -->
          <h1 class="h1 mb-3 mt-3 text-center">Practice</h1>

          <script>
          function playSound(){
            var sound = new Audio(`/audio/<%= @word %>.mp3`);
            sound.play();
          }
          </script>

          <button class="btn btn-primary " onclick="playSound()">
            <svg class="bi bi-volume-mute-fill" aria-hidden="true" width="48" height="48"><use xlink:href="#audio"/></svg>
          </button>

          <p>Hint: 5 letters</p>
          <input type="text" name="yo" label="Type What You Hear"/>




        </div>
      </main>

    """
  end
end
