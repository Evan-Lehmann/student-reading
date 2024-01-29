defmodule App.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :name, :string
      add :price, :integer
      add :image, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:rewards, [:user_id])
  end
end
