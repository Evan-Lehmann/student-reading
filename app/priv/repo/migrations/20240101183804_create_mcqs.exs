defmodule App.Repo.Migrations.CreateMcqs do
  use Ecto.Migration

  def change do
    create table(:mcqs) do
      add :word, :string
      add :image, :string
      add :audio, :string
      add :hint, :string
      add :sentence, :string
      add :difficulty, :string

      timestamps()
    end
  end
end
