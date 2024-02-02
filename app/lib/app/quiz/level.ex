defmodule App.Quiz.Level do
  use Ecto.Schema
  import Ecto.Changeset

  schema "levels" do
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(level, attrs) do
    level
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
