defmodule App.RewardsTest do
  use App.DataCase

  alias App.Rewards

  describe "rewards" do
    alias App.Rewards.Reward

    import App.RewardsFixtures

    @invalid_attrs %{name: nil, image: nil, price: nil}

    test "list_rewards/0 returns all rewards" do
      reward = reward_fixture()
      assert Rewards.list_rewards() == [reward]
    end

    test "get_reward!/1 returns the reward with given id" do
      reward = reward_fixture()
      assert Rewards.get_reward!(reward.id) == reward
    end

    test "create_reward/1 with valid data creates a reward" do
      valid_attrs = %{name: "some name", image: "some image", price: 42}

      assert {:ok, %Reward{} = reward} = Rewards.create_reward(valid_attrs)
      assert reward.name == "some name"
      assert reward.image == "some image"
      assert reward.price == 42
    end

    test "create_reward/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_reward(@invalid_attrs)
    end

    test "update_reward/2 with valid data updates the reward" do
      reward = reward_fixture()
      update_attrs = %{name: "some updated name", image: "some updated image", price: 43}

      assert {:ok, %Reward{} = reward} = Rewards.update_reward(reward, update_attrs)
      assert reward.name == "some updated name"
      assert reward.image == "some updated image"
      assert reward.price == 43
    end

    test "update_reward/2 with invalid data returns error changeset" do
      reward = reward_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_reward(reward, @invalid_attrs)
      assert reward == Rewards.get_reward!(reward.id)
    end

    test "delete_reward/1 deletes the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{}} = Rewards.delete_reward(reward)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_reward!(reward.id) end
    end

    test "change_reward/1 returns a reward changeset" do
      reward = reward_fixture()
      assert %Ecto.Changeset{} = Rewards.change_reward(reward)
    end
  end
end
