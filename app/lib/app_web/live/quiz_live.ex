defmodule AppWeb.QuizLive do
  use AppWeb, :live_view
  alias App.Quiz

  def mount(_params, _session, socket) do
    if connected?(socket) do
       socket = assign(socket,
         stories: Quiz.list_user_stories(socket.assigns.current_user.id)
       )
       {:ok, socket}
     else
       socket = assign(socket,
         stories: nil
       )
       {:ok, socket}
     end
  end

  def render(assigns) do
    ~H"""
    <.table :if={@stories} id="stories" rows={@stories}>
      <:col :let={story} label="Title"><%= story.story.title %></:col>
      <:col :let={story} label="Difficulty">
          <p :if={story.story.difficulty == "easy"} class="bg-green-800/10 text-green-700 rounded-full px-2 font-medium leading-6">
            <%= story.story.difficulty %>
          </p>
          <p :if={story.story.difficulty == "medium"} class="bg-amber-800/10 text-amber-700 rounded-full px-2 font-medium leading-6">
            <%= story.story.difficulty %>
          </p>
          <p :if={story.story.difficulty == "hard"} class="bg-rose-800/10 text-rose-700 rounded-full px-2 font-medium leading-6">
            <%= story.story.difficulty %>
          </p>
      </:col>
      <:col :let={story}>
        <%= if story.is_completed == false do %>
          <a href={~p"/quiz/#{story.story.id}"} class="rounded-lg bg-sky-600 px-2 py-1 hover:bg-sky-600/80 text-white">
            Start
          </a>
        <% else %>
          <button disabled class="rounded-lg bg-slate-300 px-2 py-1 opacity-50 text-slate-800">
            Already Completed
          </button>
        <% end %>
      </:col>
    </.table>
    """
  end
end
