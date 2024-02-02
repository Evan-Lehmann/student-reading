defmodule App.Avatars.Avatar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars" do
    field :image, :string
    field :rarity, :string
    has_many :users, App.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(avatar, attrs) do
    avatar
    |> cast(attrs, [:image, :rarity])
    |> validate_required([:image])
    |> validate_rarity
  end

  defp validate_rarity(changeset) do
    changeset
    |> validate_required([:rarity])
    |> validate_inclusion(:rarity, ["common", "uncommon", "rare", "epic"])
  end


end
