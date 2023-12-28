defmodule App.Quiz.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :content, :string
    field :is_correct, :boolean, default: false

    belongs_to :question, App.Quiz.Question

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:content, :is_correct])
    |> validate_required([:content, :is_correct])
  end
end
