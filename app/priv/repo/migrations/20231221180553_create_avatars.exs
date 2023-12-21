defmodule App.Repo.Migrations.CreateAvatars do
  use Ecto.Migration

  def change do
    create table(:avatars) do
      add :image, :string

      timestamps()
    end
  end
end
