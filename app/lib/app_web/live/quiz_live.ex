defmodule AppWeb.QuizLive do
  use AppWeb, :live_view
  alias App.Quiz
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "quiz_attempt")

    if connected?(socket) do

      {q_ids, rand} = get_next_question_id(Quiz.get_questions_of_story(1))
       socket = assign(socket,
         story: Quiz.get_story!(1),
         form: form,
         q_ids: q_ids,
         question: Quiz.get_question!(rand),
         answers: Quiz.get_answers_of_question(rand),
         stories: Quiz.list_stories
       )
       {:ok, socket}
     else
       socket = assign(socket,
         story: nil,
         form: form,
         q_ids: nil,
         question: nil,
         answers: nil,
         stories: nil
       )
       {:ok, socket}
     end
  end

  def render(assigns) do
    ~H"""
    <.table :if={@stories} id="stories" rows={@stories}>
      <:col :let={story} label="Title"><%= story.title %></:col>
      <:col :let={story} label="Difficulty">
          <p :if={story.difficulty == "easy"} class="bg-green-800/5 text-green-700 rounded-full px-2 font-medium leading-6">
            <%= story.difficulty %>
          </p>
          <p :if={story.difficulty == "medium"} class="bg-amber-800/5 text-amber-700 rounded-full px-2 font-medium leading-6">
            <%= story.difficulty %>
          </p>
          <p :if={story.difficulty == "hard"} class="bg-rose-800/5 text-rose-700 rounded-full px-2 font-medium leading-6">
            <%= story.difficulty %>
          </p>
      </:col>
      <:col :let={student}>
        <button class="rounded-lg bg-sky-600 px-2 py-1 hover:bg-sky-600/80 text-white" phx-click="remove" value={student.id}>
          Start
        </button>
      </:col>
    </.table>

    <br>
    <br>

    <div :if={@question != nil} class="flex flex-row">
      <div class="bg-slate-200 overflow-y-auto h-64 basis-1/2">
        <h2 class="text-xl font-bold">Placeholder Title</h2>
        <p> <%= @story.content %> </p>
      </div>
      <div class="basis-1/2 mx-6">
        <%= if @q_ids != nil do %>
          <.form for={@form} phx-submit="next">
            <p class="font-bold"> <%= @question.content %> </p>
            <.radio_input :for={answer <- @answers} answer_content={answer.content} answer_id={Integer.to_string(answer.id)}/>
            <.button>Check</.button>
          </.form>
        <% else %>
          <p class="text-xl text-blue-700">Finished!</p>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("next", _params, socket) do
    case get_next_question_id(socket.assigns.q_ids) do
      {q_ids, rand} ->
        {:noreply, assign(socket, q_ids: q_ids, question: Quiz.get_question!(rand), answers: Quiz.get_answers_of_question(rand))}
      {:error} ->
        {:noreply, assign(socket, q_ids: nil)}
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
