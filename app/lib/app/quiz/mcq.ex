defmodule App.Quiz.Mcq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mcqs" do
    field :content, :string
    field :image, :string
    field :audio, :string
    field :hint, :string

    timestamps()
  end

  @doc false
  def changeset(mcq, attrs) do
    mcq
    |> cast(attrs, [:content, :image])
    |> validate_required([:content])
  end
end
