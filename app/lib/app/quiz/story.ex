defmodule App.Quiz.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :content, :string

    has_many :questions, App.Quiz.Question

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
