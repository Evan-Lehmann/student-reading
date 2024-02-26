defmodule App.Rewards do
  @moduledoc """
  The Rewards context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Rewards.Reward

  @doc """
  Returns the list of rewards.

  ## Examples

      iex> list_rewards()
      [%Reward{}, ...]

  """
  def list_rewards do
    Repo.all(Reward)
  end

  @doc """
  Gets a single reward.

  Raises `Ecto.NoResultsError` if the Reward does not exist.

  ## Examples

      iex> get_reward!(123)
      %Reward{}

      iex> get_reward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward!(id), do: Repo.get!(Reward, id)

  def get_rewards_of_teacher(user_id) do
    from(r in Reward, where: r.user_id == ^user_id)
    |> Repo.all()
    #|> Repo.preload(:avatar)
  end

  def get_other_images(curr_image) do
    images = ["/images/balloons.png", "/images/basketball.png", "/images/candy.png", "/images/check.png", "/images/chips.png", "/images/cup.png", "/images/football.png", "/images/fruit.png", "/images/game.png", "/images/hundred.png", "/images/ipad.png", "/images/juice.png", "/images/lolipop.png", "/images/paw.png", "/images/pizza.png", "/images/popcorn.png", "/images/present.png", "/images/soccer.png", "/images/ticket.png"]
    Enum.filter(images, fn x -> x !=
    curr_image end)
  end

  def get_price_by_id(id) do
    Repo.one(from u in Reward,
      where: u.id == ^id,
      select: u.price)
  end

  def get_name_by_id(id) do
    Repo.one(from u in Reward,
      where: u.id == ^id,
      select: u.name)
  end

  def get_image_by_id(id) do
    Repo.one(from u in Reward,
      where: u.id == ^id,
      select: u.image)
  end


  @doc """
  Creates a reward.

  ## Examples

      iex> create_reward(%{field: value})
      {:ok, %Reward{}}

      iex> create_reward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward(attrs \\ %{}) do
    %Reward{}
    |> Reward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward.

  ## Examples

      iex> update_reward(reward, %{field: new_value})
      {:ok, %Reward{}}

      iex> update_reward(reward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward.

  ## Examples

      iex> delete_reward(reward)
      {:ok, %Reward{}}

      iex> delete_reward(reward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward(%Reward{} = reward) do
    Repo.delete(reward)
  end

  def delete_reward_by_id(id) do
    reward = Repo.get!(Reward, id)
    Repo.delete(reward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward changes.

  ## Examples

      iex> change_reward(reward)
      %Ecto.Changeset{data: %Reward{}}

  """
  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end
end
