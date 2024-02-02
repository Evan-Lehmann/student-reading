defmodule App.Repo.Migrations.AddLevelRefToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :level_id, references(:levels, on_delete: :nothing)
    end

    create index(:users, [:level_id])
  end
end
