defmodule App.Quiz.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :content, :string

    belongs_to :story, App.Quiz.Story
    has_many :answers, App.Quiz.Answer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
