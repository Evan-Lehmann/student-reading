defmodule AppWeb.PlayEasy do
  use AppWeb, :live_view
  import AppWeb.CustomComponents
  alias App.Quiz
  alias App.Accounts

  def mount(_params, _session, socket) do
    curr_points = socket.assigns.current_user.points
    if connected?(socket) do
      mcq_word = Quiz.get_mcq_by_difficulty("easy")
      inc_words = Quiz.get_inc_words(mcq_word)
      all_words = Enum.shuffle([mcq_word | inc_words])
      {:ok, assign(socket, word: mcq_word, all_words: all_words, view: nil, result: nil, selected: nil, points: curr_points)}
    else
      {:ok, assign(socket, word: nil, all_words: nil, view: nil, result: nil, selected: nil, points: curr_points)}
    end
  end

  def render(assigns) do
    ~H"""

    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
        <symbol id="sound" viewBox="0 0 16 16">
          <path d="M11.536 14.01A8.47 8.47 0 0 0 14.026 8a8.47 8.47 0 0 0-2.49-6.01l-.708.707A7.48 7.48 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303z"></path>
          <path d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.48 5.48 0 0 1 11.025 8a5.48 5.48 0 0 1-1.61 3.89z"></path>
          <path d="M8.707 11.182A4.5 4.5 0 0 0 10.025 8a4.5 4.5 0 0 0-1.318-3.182L8 5.525A3.5 3.5 0 0 1 9.025 8 3.5 3.5 0 0 1 8 10.475zM6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06"></path>
        </symbol>
    </svg>


    <main class="d-flex flex-nowrap">
      <.student_sidebar active_tab="play">
      </.student_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-hidden">
        <div class="position-absolute top-0 end-0">
          <.link href={~p"/play"}><button type="button" class="btn-close m-3" aria-label="Close"></button></.link>
        </div>

        <div class="position-absolute top-0 start-0" style={"margin-left:5.5rem;margin-top:16px;"}>
          <p class="h5">Your Points: <span class="bg-points text-points rounded-full px-2 font-medium leading-6"><%= @points %> </span></p>
        </div>

        <script>
          function playSound(word){
            var sound = new Audio(`/audio/${word}.mp3`);
            sound.play();
          }
        </script>

        <button :if={is_nil(@word) == false} onclick={"playSound('#{@word}')"} class="btn btn-regular d-flex align-items-center justify-content-center mb-2 w-full" style={"max-width:500px;min-width:250px;margin-top:25px;"}>
          <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-volume-up-fill m-0 p-0 d-inline-block " viewBox="0 0 16 16">
            <path d="M11.536 14.01A8.47 8.47 0 0 0 14.026 8a8.47 8.47 0 0 0-2.49-6.01l-.708.707A7.48 7.48 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303z"></path>
            <path d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.48 5.48 0 0 1 11.025 8a5.48 5.48 0 0 1-1.61 3.89z"></path>
            <path d="M8.707 11.182A4.5 4.5 0 0 0 10.025 8a4.5 4.5 0 0 0-1.318-3.182L8 5.525A3.5 3.5 0 0 1 9.025 8 3.5 3.5 0 0 1 8 10.475zM6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06"></path>
          </svg>
          <span class="lead">What word is this?</span>
        </button>



        <div class="container px-0" style={"max-width:500px"}>
          <div class="row">
            <%= if is_nil(@word) == false do %>
              <%= for answer <- @all_words do %>
                <%= if @view == nil do %>
                  <div class="col">
                    <button class="btn btn-outline-dark w-full" phx-click="check" phx-value-answer={answer}>
                      <%= answer %>
                    </button>
                  </div>
                <% else %>
                  <%= if answer == @selected do %>
                    <%= if @result == true do %>
                      <div class="col">
                        <button disabled class="btn btn-success w-full">
                          <%= answer %>
                        </button>
                        <span class="font-bold text-emerald-600">+25</span>
                      </div>
                    <% else %>
                      <div class="col">
                        <button disabled class="btn btn-danger w-full">
                          <%= answer %>
                        </button>
                        <span class="font-bold text-red-600">-25</span>
                      </div>
                    <% end %>
                  <% else %>
                    <div class="col">
                      <button class="btn btn-outline-dark w-full" disabled>
                        <%= answer %>
                      </button>
                    </div>
                  <% end %>
                <% end %>
              <% end %>
            <% end %>
          </div>
        </div>

        <button class="mt-2 lead" :if={@view == "checked"} phx-click="next"><b>Next →</b></button>

      </div>
    </main>
    """
  end

  def handle_event("check", %{"answer" => answer}, socket) do
    result = nil
    if answer == socket.assigns.word do
      result = true
      points = socket.assigns.points + 25
      Accounts.update_user_points(socket.assigns.current_user, %{"points" => Integer.to_string(points)})
      {:noreply, assign(socket, view: "checked", result: result, points: points, selected: answer)}
    else
      result = false
      points = socket.assigns.points - 25
      Accounts.update_user_points(socket.assigns.current_user, %{"points" => Integer.to_string(points)})
      {:noreply, assign(socket, view: "checked", result: result, points: points, selected: answer)}
    end
  end

  def handle_event("next", _params, socket) do
    next_word = Quiz.get_mcq_by_difficulty_and_last_word("easy", socket.assigns.word)
    inc_words = Quiz.get_inc_words(next_word)
    all_words =  Enum.shuffle([next_word | inc_words])

    {:noreply, assign(socket, word: next_word, inc_words: inc_words, all_words: all_words, view: nil, selected: nil, result: nil)}
  end
end
