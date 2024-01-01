defmodule App.Repo.Migrations.CreateCompletedStories do
  use Ecto.Migration

  def change do
    create table(:completed_stories) do
      add :is_completed, :boolean, default: false, null: false
      add :story_id, references(:stories, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:completed_stories, [:story_id])
    create index(:completed_stories, [:user_id])
  end
end
