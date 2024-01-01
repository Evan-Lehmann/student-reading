defmodule AppWeb.QuizIndex do
  use AppWeb, :live_view
  alias App.Quiz
  alias App.Accounts

  def mount(%{"id" => story_id}, _sesion, socket) do
    form = to_form(%{}, as: "quiz_attempt")

    if connected?(socket) do
      {q_ids, rand} = get_next_question_id(Quiz.get_questions_of_story(story_id))
      socket = assign(socket,
        story: Quiz.get_story!(story_id),
        story_id: story_id,
        form: form,
        q_ids: q_ids,
        question: Quiz.get_question!(rand),
        answers: Quiz.get_answers_of_question(rand),
        results: [],
        score: nil,
        selected: nil
      )
      {:ok, socket}
    else
      socket = assign(socket,
        story: nil,
        story_id: nil,
        form: form,
        q_ids: nil,
        question: nil,
        answers: nil,
        score: nil,
        selected: nil
      )
      {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div :if={@question != nil} class="flex flex-row">
      <div class="bg-slate-200 overflow-y-auto h-64 basis-1/2">
        <h2 class="text-xl font-bold">Placeholder Title</h2>
        <p> <%= @story.content %> </p>
      </div>

      <div class="basis-1/2 mx-6">

        <%= if @q_ids != nil do %>
          <p class="font-bold"> <%= @question.content %> </p>

          <br>
          <%= for answer <- @answers do %>
            <%= if answer.id == @selected do %>
              <.button disabled class="bg-stone-700">
                <%= answer.content %>
              </.button>
              <br>
              <hr>
            <% else %>
              <.button class="bg-stone-400" phx-click="select" phx-value-answer_id={answer.id}>
                <%= answer.content %>
              </.button>
              <br>
              <hr>
            <% end %>
          <% end %>

          <.simple_form for={@form} phx-submit="next">
            <%= if @selected != nil  do %>
              <.input field={@form[:answer_id]} type="text" value={@selected} readonly required />
              <.button phx-disable-with="Changing" class="w-full">
                Submit
              </.button>
            <% else %>
              <.button disabled class="w-full opacity-50">
                Submit
              </.button>
            <% end %>
          </.simple_form>

        <% else %>
          <p class="text-xl text-blue-700 py-4">Finished!</p>
          <%= if @score >= 70 do %>
            <span class="text-lg font-bold text-emerald-700">Score: <%= @score %>% </span>
          <% else %>
            <span class="text-lg font-bold text-amber-700">Score: <%= @score %>% </span>
          <% end %>
          <a href={~p"/quiz_live"} class="rounded-lg bg-sky-600 px-2 py-1 hover:bg-sky-600/80 text-white my-4">
            Back to Menu
          </a>
        <% end %>
      </div>

    </div>
    """
  end

  def handle_event("select", %{"answer_id" => answer_id}, socket) do
    {:noreply, assign(socket, selected: String.to_integer(answer_id))}
  end

  def handle_event("next", %{"quiz_attempt" => %{"answer_id" => answer_id}}, socket) do
    case get_next_question_id(socket.assigns.q_ids) do
      {q_ids, rand} ->
        result = Quiz.get_answer!(answer_id).is_correct
        updated_results = [result | socket.assigns.results]
        {:noreply, assign(socket, results: updated_results, q_ids: q_ids, question: Quiz.get_question!(rand), answers: Quiz.get_answers_of_question(rand), selected: nil)}
      {:error} ->
        result = Quiz.get_answer!(answer_id).is_correct
        updated_results = [result | socket.assigns.results]

        number_answered = length(updated_results)
        number_correct = length(Enum.filter(updated_results, fn x -> x == true end))
        score = (number_correct / number_answered) * 100

        completed_story = Quiz.get_completed_story_by_user_id_and_story_id(socket.assigns.current_user.id, socket.assigns.story_id)
        Quiz.update_completed_story(completed_story, %{is_completed: true})

        if score >= 70 do
          Accounts.update_user_cash(socket.assigns.current_user, %{"cash" => Integer.to_string(socket.assigns.current_user.cash + 300)})
        end

        {:noreply, assign(socket, q_ids: nil, results: updated_results, score: score, selected: nil)}
    end
  end

  defp get_next_question_id(q_ids) do
    if length(q_ids) > 0 do
      rand = Enum.random(q_ids)
      q_ids = List.delete(q_ids, rand)
      {q_ids, rand}
    else
      {:error}
    end
  end

end
