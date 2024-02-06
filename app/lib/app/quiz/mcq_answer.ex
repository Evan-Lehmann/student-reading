defmodule App.Quiz.McqAnswer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mcqs_answers" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(mcq_answer, attrs) do
    mcq_answer
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
