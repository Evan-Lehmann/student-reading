defmodule App.Repo.Migrations.CreateMcqsAnswers do
  use Ecto.Migration

  def change do
    create table(:mcqs_answers) do
      add :content, :string
      add :mcq_id, references(:mcqs, on_delete: :nothing)
      add :is_correct, :boolean

      timestamps()
    end

    create index(:mcqs_answers, [:mcq_id])
  end
end
