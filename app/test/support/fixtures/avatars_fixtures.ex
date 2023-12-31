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

  @doc """
  Generate a avatar_access.
  """
  def avatar_access_fixture(attrs \\ %{}) do
    {:ok, avatar_access} =
      attrs
      |> Enum.into(%{
        is_unlocked: true
      })
      |> App.Avatars.create_avatar_access()

    avatar_access
  end
end
