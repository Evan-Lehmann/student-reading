defmodule App.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Accounts.{User, UserToken}
  alias App.Avatars.AvatarAccess
  alias App.Quiz.CompletedStory
  alias App.Avatars
  alias App.Quiz
  alias App.Rewards.Reward

  ## Database getters

  @doc """
  Gets a user by email.

  ## Examples

      iex> get_user_by_email("foo@example.com")
      %User{}

      iex> get_user_by_email("unknown@example.com")
      nil

  """
  def get_user_by_username(username) when is_binary(username) do
    Repo.get_by(User, username: username)
  end

  def list_teacher_names do
    Repo.all(from u in User,
      where: u.type == "teacher",
      select: u.username)
  end

  def list_teacher_ids do
    Repo.all(from u in User,
      where: u.type == "teacher",
      select: u.id)
  end

  def list_student_names_in_class(class) do
    Repo.all(from u in User,
      where: u.type == "student" and u.class == ^class,
      select: u.username)
  end

  def list_students_in_class(class) do
    (from u in User, where: u.type == "student" and u.class == ^class, order_by: [desc: u.cash])
    |> Repo.all()
    |> Repo.preload(:avatar)
  end
  @doc """
  Gets a user by email and password.

  ## Examples

      iex> get_user_by_email_and_password("foo@example.com", "correct_password")
      %User{}

      iex> get_user_by_email_and_password("foo@example.com", "invalid_password")
      nil

  """
  def get_user_by_username_and_password(username, password)
      when is_binary(username) and is_binary(password) do
    user = Repo.get_by(User, username: username)
    if User.valid_password?(user, password), do: user
  end

  def get_avatar_image_by_user(user) do
    Ecto.assoc(user, :avatar)

    Repo.one(from u in Ecto.assoc(user, :avatar),
      select: u.image)
  end

  def get_avatar_rarity_by_user(user) do
    Ecto.assoc(user, :avatar)

    Repo.one(from u in Ecto.assoc(user, :avatar),
      select: u.rarity)
  end


  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  ## User registration

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs) do
    %{"type" => type, "username" => username} = attrs

    result = %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()

    if type == "student" do
      Enum.each(1..2, fn(x) ->
        user_id = get_user_by_username(username).id
        %AvatarAccess{}
        |> AvatarAccess.changeset(%{"avatar_id" => Integer.to_string(x), "user_id" => Integer.to_string(user_id), "is_unlocked" => "true"})
        |> Repo.insert()
      end)

      Enum.each(3..4, fn(x) ->
        user_id = get_user_by_username(username).id
        %AvatarAccess{}
        |> AvatarAccess.changeset(%{"avatar_id" => Integer.to_string(x), "user_id" => Integer.to_string(user_id), "is_unlocked" => "false"})
        |> Repo.insert()
      end)

      stories_ids = Quiz.list_stories_ids

      Enum.each(stories_ids, fn(x) ->
        user_id = get_user_by_username(username).id
        %CompletedStory{}
        |> CompletedStory.changeset(%{"story_id" => Integer.to_string(x), "user_id" => Integer.to_string(user_id), "is_completed" => "false"})
        |> Repo.insert()
      end)
    end

    if type == "teacher" do
      user_id = get_user_by_username(username).id

      %Reward{}
      |> Reward.changeset(%{"name" => "lorem", "price" => 1000, "image" => "/images/a.PNG", "user_id" => Integer.to_string(user_id)})
      |> Repo.insert()
    end

    result
  end

  def unlock_avatar(user, locked_avatars_ids) do
    if user.cash >= 500 && length(locked_avatars_ids) > 0 do

      rand = Enum.random(Enum.to_list(locked_avatars_ids))
      avatar_access = Avatars.get_avatar_access_by_avatar_id(user.id, rand)
      updated_avatars_access = Avatars.update_avatar_access(avatar_access, %{"is_unlocked" => "true"})

      updated_user = user
      |> User.cash_changeset(%{cash: (user.cash-500)})
      |> Repo.update()

      {updated_user, updated_avatars_access}
    else
      {:error, :error}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user_registration(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs, hash_password: false, validate_username: false)
  end

  ## Settings

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the user password.

  ## Examples

      iex> change_user_password(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_password(user, attrs \\ %{}) do
    User.password_changeset(user, attrs, hash_password: false)
  end

  @doc """

  """
  def change_user_avatar(user, attrs \\ %{}) do
    User.avatar_id_changeset(user, attrs)
  end


  def change_user_class(user, attrs \\ %{}) do
    User.class_changeset(user, attrs)
  end

  @doc """
  Updates the user password.

  ## Examples

      iex> update_user_password(user, "valid password", %{password: ...})
      {:ok, %User{}}

      iex> update_user_password(user, "invalid password", %{password: ...})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_password(user, password, attrs) do
    changeset =
      user
      |> User.password_changeset(attrs)
      |> User.validate_current_password(password)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, changeset)
    |> Ecto.Multi.delete_all(:tokens, UserToken.by_user_and_contexts_query(user, :all))
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user}} -> {:ok, user}
      {:error, :user, changeset, _} -> {:error, changeset}
    end
  end

  @doc """
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.avatar_id_changeset(attrs)
    |> Repo.update()
  end

  def get_teacher_name_by_join_code(join_code) do
    Repo.one(from u in User,
      where: u.join_code == ^join_code,
      select: u.username)
  end

  def update_user_class(%User{} = user, attrs) do
    user
    |> User.class_changeset(attrs)
    |> Repo.update()
  end

  def update_user_cash(%User{} = user, attrs) do
    user
    |> User.cash_changeset(attrs)
    |> Repo.update()
  end


  ## Session

  @doc """
  Generates a session token.
  """
  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  @doc """
  Gets the user with the given signed token.
  """
  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end
end
