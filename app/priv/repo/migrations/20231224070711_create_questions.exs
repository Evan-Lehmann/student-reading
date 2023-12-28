defmodule App.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :content, :string
      add :story_id, references(:stories, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:story_id])
  end
end
