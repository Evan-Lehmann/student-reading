defmodule App.Quiz.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :content, :string
    field :title, :string
    field :difficulty, :string

    has_many :questions, App.Quiz.Question

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:content, :title, :difficulty])
    |> validate_required([:content])
    |> validate_required([:title])
    |> validate_difficulty
  end

  defp validate_difficulty(changeset) do
    changeset
    |> validate_required([:difficulty])
    |> validate_inclusion(:difficulty, ["easy", "medium", "hard"])
  end

end
