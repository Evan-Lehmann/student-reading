defmodule App.Repo.Migrations.CreateLevels do
  use Ecto.Migration

  def change do
    create table(:levels) do
      add :number, :integer

      timestamps()
    end
  end
end
