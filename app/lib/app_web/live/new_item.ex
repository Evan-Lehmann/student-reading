defmodule AppWeb.NewItem do
  use AppWeb, :live_view
  alias App.Rewards.Reward
  alias App.Rewards
  import AppWeb.CustomComponents

  def mount(_params, _session, socket) do
    changeset = Rewards.change_reward(%Reward{})
    curr_image = "/images/present.png"
    other_images = Rewards.get_other_images(curr_image)
    all_images = [curr_image | other_images]
    {:ok, socket |> assign(check_errors: false, curr_image: curr_image, all_images: all_images, name: nil, price: nil) |> assign_form(changeset)}
  end

  def render(assigns) do
    ~H"""

    <main class="d-flex flex-nowrap">
      <.teacher_sidebar active_tab="rewards">
      </.teacher_sidebar>

      <div class="flex-grow-1 d-flex flex-column align-items-center p-4 overflow-scroll">
        <h1 class="h1 mt-3 text-center">New Item</h1>
        <.link navigate={~p"/shop"} class="font-semibold text-blue-700 hover:underline">
          Go Back
        </.link>

        <!-- homeModal -->
        <div class="modal fade" id="homeModal" tabindex="-1" aria-labelledby="homeModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="homeModalLabel">Choose Image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body" style={"padding-top:0;"}>
                <div class="container overflow-y-scroll" style={"max-height:300px;"}>
                  <div class="row row-cols-3">
                    <div :for={image <- @all_images} class="col d-flex justify-content-center">
                      <%= if image == @curr_image do %>
                        <button class="btn btn-outline-dark active" style={"margin-top:20px;"}>
                          <image id="form-image" class="" style={"width: 46px;height:46px;min-width:46px;"} src={image} />
                        </button>
                      <% else %>
                        <button phx-click={"change"} phx-value-new_image={image} data-bs-dismiss="modal" class="btn btn-outline-dark" style={"margin-top:20px;"}>
                          <image id="form-image" class="" style={"width: 46px;height:46px;min-width:46px;"} src={image} />
                        </button>
                      <% end %>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>


        <div style={"width:354px;"}>
          <.simple_form  for={@form} phx-submit="save_item">
            <.input field={@form[:name]} label="Item Name" type="text" required/>
            <.input field={@form[:price]} label="Points" type="number" min={250} max={100000} required/>
            <.label>Image</.label>
            <div style={"margin-top:1px;"}>
              <a class="btn btn-regular" data-bs-toggle="modal" data-bs-target="#homeModal">
                <image id="form-image" class="" style={"width: 46px;height:46px;min-width:46px;"} src={@curr_image} />
              </a>
              <a data-bs-toggle="modal" data-bs-target="#homeModal" type="button" class="text-blue-700">
                Change
              </a>
            </div>
            <.button class="w-full mt-3">Check</.button>
          </.simple_form>
        </div>
      </div>
    </main>
    """
  end

  def handle_event("change", %{"new_image" => new_image}, socket) do
    {:noreply, assign(socket, curr_image: new_image)}
  end

  def handle_event("save_item", %{"reward" => reward_params}, socket) do
    complete_reward_params = reward_params |> Map.put("user_id", socket.assigns.current_user.id) |> Map.put("image", socket.assigns.curr_image)
    case Rewards.create_reward(complete_reward_params) do
      {:ok, _} ->
        {:noreply,
           socket
           |> redirect(to: ~p"/shop")
           |> put_flash(:info, "Item created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign_form(changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "reward")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
