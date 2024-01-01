defmodule App.Avatars do
  @moduledoc """
  The Avatars context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Avatars.Avatar

  @doc """
  Returns the list of avatars.

  ## Examples

      iex> list_avatars()
      [%Avatar{}, ...]

  """
  def list_avatars do
    Repo.all(Avatar)
  end

  @doc """
  Gets a single avatar.

  Raises `Ecto.NoResultsError` if the Avatar does not exist.

  ## Examples

      iex> get_avatar!(123)
      %Avatar{}

      iex> get_avatar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_avatar!(id), do: Repo.get!(Avatar, id)

  @doc """
  Creates a avatar.

  ## Examples

      iex> create_avatar(%{field: value})
      {:ok, %Avatar{}}

      iex> create_avatar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_avatar(attrs \\ %{}) do
    %Avatar{}
    |> Avatar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a avatar.

  ## Examples

      iex> update_avatar(avatar, %{field: new_value})
      {:ok, %Avatar{}}

      iex> update_avatar(avatar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_avatar(%Avatar{} = avatar, attrs) do
    avatar
    |> Avatar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a avatar.

  ## Examples

      iex> delete_avatar(avatar)
      {:ok, %Avatar{}}

      iex> delete_avatar(avatar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_avatar(%Avatar{} = avatar) do
    Repo.delete(avatar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking avatar changes.

  ## Examples

      iex> change_avatar(avatar)
      %Ecto.Changeset{data: %Avatar{}}

  """
  def change_avatar(%Avatar{} = avatar, attrs \\ %{}) do
    Avatar.changeset(avatar, attrs)
  end

  alias App.Avatars.AvatarAccess

  @doc """
  Returns the list of avatars_access.

  ## Examples

      iex> list_avatars_access()
      [%AvatarAccess{}, ...]

  """
  def list_avatars_access do
    Repo.all(AvatarAccess)
  end

  def list_users_avatars(user_id) do
    from(a in AvatarAccess, where: a.user_id == ^user_id)
    |> Repo.all()
    |> Repo.preload(:avatar)
  end

  def list_users_locked_avatars(user_id) do
    from(a in AvatarAccess, where: a.user_id == ^user_id and a.is_unlocked == false, select: a.avatar_id)
    |> Repo.all()
    #|> Repo.preload(:avatar)
  end

  def get_avatar_access_by_avatar_id(user_id, avatar_id) do
    from(a in AvatarAccess, where: a.user_id == ^user_id and a.avatar_id == ^avatar_id)
    |> Repo.one()
    |> Repo.preload(:avatar)
  end

  @doc """
  Gets a single avatar_access.

  Raises `Ecto.NoResultsError` if the Avatar access does not exist.

  ## Examples

      iex> get_avatar_access!(123)
      %AvatarAccess{}

      iex> get_avatar_access!(456)
      ** (Ecto.NoResultsError)

  """
  def get_avatar_access!(id), do: Repo.get!(AvatarAccess, id)

  @doc """
  Creates a avatar_access.

  ## Examples

      iex> create_avatar_access(%{field: value})
      {:ok, %AvatarAccess{}}

      iex> create_avatar_access(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_avatar_access(attrs \\ %{}) do
    %AvatarAccess{}
    |> AvatarAccess.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a avatar_access.

  ## Examples

      iex> update_avatar_access(avatar_access, %{field: new_value})
      {:ok, %AvatarAccess{}}

      iex> update_avatar_access(avatar_access, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_avatar_access(%AvatarAccess{} = avatar_access, attrs) do
    avatar_access
    |> AvatarAccess.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a avatar_access.

  ## Examples

      iex> delete_avatar_access(avatar_access)
      {:ok, %AvatarAccess{}}

      iex> delete_avatar_access(avatar_access)
      {:error, %Ecto.Changeset{}}

  """
  def delete_avatar_access(%AvatarAccess{} = avatar_access) do
    Repo.delete(avatar_access)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking avatar_access changes.

  ## Examples

      iex> change_avatar_access(avatar_access)
      %Ecto.Changeset{data: %AvatarAccess{}}

  """
  def change_avatar_access(%AvatarAccess{} = avatar_access, attrs \\ %{}) do
    AvatarAccess.changeset(avatar_access, attrs)
  end
end
