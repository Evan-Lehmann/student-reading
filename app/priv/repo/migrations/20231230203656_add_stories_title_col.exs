defmodule App.Repo.Migrations.AddStoriesTitleCol do
  use Ecto.Migration

  def change do
    alter table("stories") do
      add :title, :string
    end
  end
end
