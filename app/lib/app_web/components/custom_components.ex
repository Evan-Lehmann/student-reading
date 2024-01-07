defmodule AppWeb.CustomComponents do
  use Phoenix.Component
  use AppWeb, :html


  attr :home_page, :boolean, default: nil

  def logged_out_nav(assigns) do
    ~H"""
  <div class="container">
    <nav class="navbar navbar-expand-lg rounded">
      <div class="container-fluid">
        <a class="navbar-brand" href={~p"/"}>
          <img src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
        </a>
        <a :if={@home_page} class="btn btn-primary" href={~p"/users/log_in"}>Log in</a>
      </div>
    </nav>
  </div>
  <hr id="line">
    """
  end

  def student_nav(assigns) do
    ~H"""
    <div class="container">
      <nav class="navbar navbar-expand-lg rounded">
        <div class="container-fluid">
          <a class="navbar-brand" href={~p"/"}>
            <img loading="lazy" src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
          </a>
          <.link method="delete" class="btn btn-primary" href={~p"/users/log_out"}>Log out</.link>
        </div>
      </nav>
    </div>
    <hr id="line">
    """
  end

  def teacher_nav(assigns) do
    ~H"""
    <div class="container">
      <nav class="navbar navbar-expand-lg rounded">
        <div class="container-fluid">
          <a class="navbar-brand" href={~p"/"}>
            <img loading="lazy" src={"https://img.logoipsum.com/245.svg"} alt="Logo"/>
          </a>
          <.link method="delete" class="bg-transparent hover:bg-blue-500 text-blue-600 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded" href={~p"/users/log_out"}>Log out</.link>
        </div>
      </nav>
    </div>
    <hr id="line">
    """
  end

  ## RadioInput
  attr :answer_id, :string, required: true
  attr :answer_content, :string, required: true

  def radio_input(assigns) do
    ~H"""
      <input class="form-check-input" type="radio" name="answer_id" value={@answer_id} id={@answer_id}>
      <label class="form-check-label" for={@answer_id}>
        <%= @answer_content %>
      </label>
      <br>
    """
  end

  attr :class, :string, default: nil
  attr :src, :string, required: true
  attr :rarity, :string, default: nil
  attr :width, :string, default: nil

  def avatar(assigns) do
    ~H"""
    <img
      class={[
        "rounded-full border-4 border-solid
        #{get_avatar_color(@rarity)}",
        @class
      ]}
      loading="lazy"
      draggable="false"
      src={@src}
      width={@width}
    />
    """
  end

  defp get_avatar_color(rarity) do
    case rarity do
      "common" ->
        "border-slate-500"
      "uncommon" ->
        "border-teal-500"
      "rare" ->
        "border-blue-500"
      "epic" ->
        "border-indigo-900"
      nil ->
        ""
    end
  end
end
