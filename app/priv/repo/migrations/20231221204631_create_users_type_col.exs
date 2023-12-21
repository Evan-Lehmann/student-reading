defmodule App.Repo.Migrations.CreateUsersTypeCol do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :type, :string, null: false
    end
  end
end
