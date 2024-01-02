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
       <div id="navbar" class="container">
        <nav class="navbar navbar-expand-lg rounded">
            <div class="container-fluid">
            <a class="navbar-brand" draggable="false" href={~p"/"}>
                <img draggable="false" src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
            </a>
            <.link class="btn btn-outline-primary" method="delete" href={~p"/users/log_out"}>Log out</.link>
            </div>
        </nav>
    </div>
    <hr id="line">


    <.table :if={@stories} id="stories" rows={@stories}>
      <:col :let={story} label="Title"><%= story.story.title %></:col>
      <:col :let={story} label="Difficulty">
          <p :if={story.story.difficulty == "easy"} class="">
            <%= story.story.difficulty %>
          </p>
          <p :if={story.story.difficulty == "medium"} class="">
            <%= story.story.difficulty %>
          </p>
          <p :if={story.story.difficulty == "hard"} class="">
            <%= story.story.difficulty %>
          </p>
      </:col>
      <:col :let={story}>
        <%= if story.is_completed == false do %>
          <a href={~p"/quiz/#{story.story.id}"} class="text-primary">
            Start
          </a>
        <% else %>
          <button disabled class="">
            Already Completed
          </button>
        <% end %>
      </:col>
    </.table>
    """
  end
end
