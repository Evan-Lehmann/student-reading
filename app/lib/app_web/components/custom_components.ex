defmodule AppWeb.CustomComponents do
  use Phoenix.Component
  use AppWeb, :html


  alias Phoenix.LiveView.JS
  import AppWeb.Gettext

  ## RadioInput
  attr :answer_id, :string, required: true
  attr :answer_content, :string, required: true
  def radio_input(assigns) do
    ~H"""
    <div class="form-check">
      <input class="form-check-input" type="radio" name="answer_id" value={@answer_id} id={@answer_id}>
      <label class="form-check-label" for={@answer_id}>
        <%= @answer_content %>
      </label>
    </div>
    """
  end
end
