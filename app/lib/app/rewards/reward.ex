defmodule App.Rewards.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts


  schema "rewards" do
    field :name, :string
    field :image, :string
    field :price, :integer

    belongs_to :user, App.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [:name, :price, :image, :user_id])
    |> validate_required([:name, :price, :image, :user_id])
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:name, min: 2, max: 26)
    |> validate_image
    |> validate_user

  end

  defp validate_image(changeset) do
    changeset
    |> validate_inclusion(:image, ["/images/cup.png", "/images/chips.png", "/images/popcorn.png"])
  end

  defp validate_user(changeset) do
    teacher_ids = Accounts.list_teacher_ids
    changeset
    |> validate_inclusion(:user_id, teacher_ids)
  end
end
