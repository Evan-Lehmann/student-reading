defmodule AppWeb.QuizLive do
  use AppWeb, :live_view
  alias App.Quiz
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "quiz_attempt")

    if connected?(socket) do
      socket = assign(socket,
        story: Quiz.get_story!(1),
        form: form,
        question: Quiz.get_question!(1),
        answers: Quiz.get_answers_of_question(1),
        checking: false
      )
      {:ok, socket}
    else
      socket = assign(socket,
        story: nil,
        form: form,
        question: nil,
        answers: nil,
        checking: nil
      )
      {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div :if={@checking != nil} class="flex flex-row">
      <div class="bg-slate-200 overflow-y-auto h-64 basis-1/2">
        <h2 class="text-xl font-bold">Placeholder Title</h2>
        <p> <%= @story.content %> </p>
      </div>
      <div class="basis-1/2 mx-6">
        <%= if @checking == true do %>
          <p class="font-bold"> <%= @question.content %> </p>
          <p class="font-bold text-red-800">Incorrect</p>
          <.button phx-click="next">Next</.button>
        <% else %>
         <.form for={@form} phx-submit="save">
            <p class="font-bold"> <%= @question.content %> </p>
            <.radio_input :for={answer <- @answers} answer_content={answer.content} answer_id={Integer.to_string(answer.id)}/>
            <.button>Check</.button>
          </.form>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("save", _, socket) do
    socket = assign(socket, checking: true)
    {:noreply, socket}
  end

  def handle_event("next", _, socket) do
    socket = assign(socket, checking: false)
    {:noreply, socket}
  end
end
