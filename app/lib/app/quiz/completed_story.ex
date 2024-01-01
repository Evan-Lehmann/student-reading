defmodule App.Quiz.CompletedStory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "completed_stories" do
    field :is_completed, :boolean, default: false

    belongs_to :story, App.Quiz.Story
    belongs_to :user, App.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(completed_story, attrs) do
    completed_story
    |> cast(attrs, [:is_completed, :user_id, :story_id])
    |> validate_required([:is_completed])
  end
end
