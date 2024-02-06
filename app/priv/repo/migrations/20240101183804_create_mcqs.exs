defmodule App.Repo.Migrations.CreateMcqs do
  use Ecto.Migration

  def change do
    create table(:mcqs) do
      add :content, :string
      add :image, :string
      add :audio, :string
      add :hint, :string

      timestamps()
    end
  end
end
