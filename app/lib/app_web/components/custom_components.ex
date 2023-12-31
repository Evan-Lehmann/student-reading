defmodule AppWeb.CustomComponents do
  use Phoenix.Component
  use AppWeb, :html

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
