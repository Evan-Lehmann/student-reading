defmodule App.Repo.Migrations.CreateUsersCashCol do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :cash, :integer, null: false
    end
  end
end
