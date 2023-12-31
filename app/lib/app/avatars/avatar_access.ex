defmodule App.Avatars.AvatarAccess do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars_access" do
    field :is_unlocked, :boolean, default: false

    belongs_to :avatar, App.Avatars.Avatar
    belongs_to :user, App.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(avatar_access, attrs) do
    avatar_access
    |> cast(attrs, [:is_unlocked, :user_id, :avatar_id])
    |> validate_required([:is_unlocked])
  end
end
