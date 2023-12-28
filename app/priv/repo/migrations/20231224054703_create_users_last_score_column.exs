defmodule App.Repo.Migrations.CreateUsersLastScoreColumn do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :last_score, :integer
    end
  end
end
