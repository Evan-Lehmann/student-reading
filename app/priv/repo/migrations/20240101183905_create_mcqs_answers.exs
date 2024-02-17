defmodule App.Repo.Migrations.CreateMcqsAnswers do
  use Ecto.Migration

  def change do
    create table(:mcqs_answers) do
      add :word, :string
      add :hint, :string

      timestamps()
    end

  end
end
