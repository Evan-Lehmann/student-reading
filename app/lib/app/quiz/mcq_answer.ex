defmodule App.Quiz.McqAnswer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mcqs_answers" do
    field :word, :string
    field :hint, :string

    timestamps()
  end

  @doc false
  def changeset(mcq_answer, attrs) do
    mcq_answer
    |> cast(attrs, [:word, :hint])
    |> validate_required([:word])
  end
end
