defmodule App.Repo.Migrations.FixUserAvatarCol do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :avatar
      add :avatar_id, references(:avatars, on_delete: :nothing)
    end

    create index(:users, [:avatar_id])
  end
end
