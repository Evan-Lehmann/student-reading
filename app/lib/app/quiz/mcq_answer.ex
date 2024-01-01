defmodule App.Quiz.McqAnswer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mcqs_answers" do
    field :content, :string
    field :is_correct, :boolean

    belongs_to :mcq, App.Quiz.Mcq

    timestamps()
  end

  @doc false
  def changeset(mcq_answer, attrs) do
    mcq_answer
    |> cast(attrs, [:content, :mcq_id, :is_correct])
    |> validate_required([:content])
    |> validate_required([:is_correct])
    |> validate_required([:mcq_id])
  end
end
