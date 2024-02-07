defmodule App.Quiz.Mcq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mcqs" do
    field :word, :string
    field :image, :string
    field :audio, :string
    field :hint, :string
    field :sentence, :string
    field :difficulty, :string

    timestamps()
  end

  @doc false
  def changeset(mcq, attrs) do
    mcq
    |> cast(attrs, [:word, :image, :audio, :hint, :sentence, :difficulty])
    |> validate_required([:word])
    |> validate_difficulty
  end

  defp validate_difficulty(changeset) do
    changeset
    |> validate_inclusion(:difficulty, ["easy", "medium", "hard"])
  end
end
