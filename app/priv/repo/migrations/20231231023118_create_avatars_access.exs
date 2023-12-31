defmodule App.Repo.Migrations.CreateAvatarsAccess do
  use Ecto.Migration

  def change do
    create table(:avatars_access) do
      add :is_unlocked, :boolean, default: false, null: false
      add :avatar_id, references(:avatars, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:avatars_access, [:avatar_id])
    create index(:avatars_access, [:user_id])
  end
end
