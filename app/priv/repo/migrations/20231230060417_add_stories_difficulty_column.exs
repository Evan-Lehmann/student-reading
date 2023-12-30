defmodule App.Repo.Migrations.AddStoriesDifficultyColumn do
  use Ecto.Migration

  def change do
    alter table("stories") do
      add :difficulty, :string
    end
  end
end
