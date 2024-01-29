defmodule App.RewardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Rewards` context.
  """

  @doc """
  Generate a reward.
  """
  def reward_fixture(attrs \\ %{}) do
    {:ok, reward} =
      attrs
      |> Enum.into(%{
        image: "some image",
        name: "some name",
        price: 42
      })
      |> App.Rewards.create_reward()

    reward
  end
end
