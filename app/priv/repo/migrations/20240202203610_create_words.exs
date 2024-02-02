defmodule App.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :content, :string
      add :hint, :string
      add :sentence, :string
      add :sound, :string

      timestamps()
    end
  end
end
