defmodule App.AvatarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Avatars` context.
  """

  @doc """
  Generate a avatar.
  """
  def avatar_fixture(attrs \\ %{}) do
    {:ok, avatar} =
      attrs
      |> Enum.into(%{
        image: "some image"
      })
      |> App.Avatars.create_avatar()

    avatar
  end
end
