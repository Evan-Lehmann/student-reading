defmodule App.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :content, :string

      timestamps()
    end
  end
end
