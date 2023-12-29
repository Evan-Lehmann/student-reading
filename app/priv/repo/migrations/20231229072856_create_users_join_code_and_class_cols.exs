defmodule App.Repo.Migrations.CreateUsersJoinCodeAndClassCols do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :join_code, :string
      add :class, :string
    end

    create unique_index(:users, [:join_code])
  end
end
