defmodule App.Repo.Migrations.CreateAvatarsRarityMigration do
  use Ecto.Migration

  def change do
    alter table("avatars") do
      add :rarity, :string, null: false
    end
  end
end
