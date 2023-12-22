defmodule App.Repo.Migrations.RemoveUsersTypeCol do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :type
    end
  end
end
