defmodule App.Repo.Migrations.ChangeQuizStoriesContextDataType do
  use Ecto.Migration

  def change do
    alter table("stories") do
      modify :content, :text
    end
  end
end
