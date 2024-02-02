defmodule App.Quiz.Word do
  use Ecto.Schema
  import Ecto.Changeset

  schema "words" do
    field :content, :string
    field :hint, :string
    field :sentence, :string
    field :sound, :string

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:content, :hint, :sentence, :sound])
    |> validate_required([:content, :sound])
  end
end
