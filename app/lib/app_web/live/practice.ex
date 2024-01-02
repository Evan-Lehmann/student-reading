defmodule AppWeb.Practice do
  use AppWeb, :live_view
  alias App.Quiz
  alias App.Accounts

  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "mcq_attempt")
    if connected?(socket) do
      list_mcqs = Quiz.list_mcqs
      rand = Enum.random(list_mcqs).id
      {:ok, assign(socket,
        form: form,
        list_mcqs: Quiz.list_mcqs,
        curr_mcq: Quiz.get_mcq!(rand),
        curr_answers: Quiz.get_answers_of_mcq(rand),
        selected: nil,
        view: nil,
        result: nil)}
    else
      {:ok, assign(socket,
        form: form,
        list_mcqs: nil,
        curr_mcq: nil,
        curr_answers: nil,
        selected: nil,
        view: nil,
        result: nil)}
    end
  end

  def render(assigns) do
    ~H"""
    <%= if @list_mcqs != nil do %>
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

      <div>
        <span class="text-lg"><%= @curr_mcq.content %></span>
        <img src={@curr_mcq.image} class="d-block mx-sm-auto img-fluid" loading="lazy" draggable="false"/>

        <%= for answer <- @curr_answers do %>
          <%= if @view == nil || @view == "changed" do %>
            <%= if answer.id == @selected do %>
              <button disabled class="btn btn-dark">
                <%= answer.content %>
              </button>
            <% else %>
              <button class="btn btn-outline-dark" phx-click="select" phx-value-answer_id={answer.id}>
                <%= answer.content %>
              </button>
            <% end %>
          <% else %>
            <%= if answer.id == @selected do %>
              <%= if @result == true do %>
                <button disabled class="btn btn-success">
                  <%= answer.content %>
                </button>
                <span class="font-bold text-emerald-600">+$25</span>
              <% else %>
                <button disabled class="btn btn-danger">
                  <%= answer.content %>
                </button>
                <span class="font-bold text-red-600">-$25</span>
              <% end %>
            <% else %>
              <button class="btn btn-dark-outline" disabled>
                <%= answer.content %>
              </button>
            <% end %>
          <% end %>
        <% end %>

        <.simple_form for={@form} phx-submit="check">
          <%= if @view == "changed"  do %>
            <.input field={@form[:answer_id]} type="hidden" value={@selected} readonly required />
            <.button phx-disable-with="Changing" class="w-full">
              Submit
            </.button>
          <% end %>
        </.simple_form>

        <.button :if={@view == "checked"} phx-click="next">Next</.button>

      </div>
    <% end %>
    """
  end

  def handle_event("select", %{"answer_id" => answer_id}, socket) do
    {:noreply, assign(socket, selected: String.to_integer(answer_id), view: "changed")}
  end

  def handle_event("check", %{"mcq_attempt" => %{"answer_id" => answer_id}}, socket) do
    result = Quiz.is_mcq_answer_correct(String.to_integer(answer_id))

    if result == true do
      Accounts.update_user_cash(socket.assigns.current_user, %{"cash" => Integer.to_string(socket.assigns.current_user.cash + 25)})
    end

    if result == false do
      Accounts.update_user_cash(socket.assigns.current_user, %{"cash" => Integer.to_string(socket.assigns.current_user.cash - 15)})
    end

    {:noreply, assign(socket, view: "checked", result: result)}
  end

  def handle_event("next", _params, socket) do
    rand = Enum.random(socket.assigns.list_mcqs).id

    {:noreply, assign(socket, view: nil, selected: nil, result: nil, curr_mcq: Quiz.get_mcq!(rand), curr_answers: Quiz.get_answers_of_mcq(rand))}
  end
end
