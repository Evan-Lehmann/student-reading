defmodule App.AvatarsTest do
  use App.DataCase

  alias App.Avatars

  describe "avatars" do
    alias App.Avatars.Avatar

    import App.AvatarsFixtures

    @invalid_attrs %{image: nil}

    test "list_avatars/0 returns all avatars" do
      avatar = avatar_fixture()
      assert Avatars.list_avatars() == [avatar]
    end

    test "get_avatar!/1 returns the avatar with given id" do
      avatar = avatar_fixture()
      assert Avatars.get_avatar!(avatar.id) == avatar
    end

    test "create_avatar/1 with valid data creates a avatar" do
      valid_attrs = %{image: "some image"}

      assert {:ok, %Avatar{} = avatar} = Avatars.create_avatar(valid_attrs)
      assert avatar.image == "some image"
    end

    test "create_avatar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatars.create_avatar(@invalid_attrs)
    end

    test "update_avatar/2 with valid data updates the avatar" do
      avatar = avatar_fixture()
      update_attrs = %{image: "some updated image"}

      assert {:ok, %Avatar{} = avatar} = Avatars.update_avatar(avatar, update_attrs)
      assert avatar.image == "some updated image"
    end

    test "update_avatar/2 with invalid data returns error changeset" do
      avatar = avatar_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatars.update_avatar(avatar, @invalid_attrs)
      assert avatar == Avatars.get_avatar!(avatar.id)
    end

    test "delete_avatar/1 deletes the avatar" do
      avatar = avatar_fixture()
      assert {:ok, %Avatar{}} = Avatars.delete_avatar(avatar)
      assert_raise Ecto.NoResultsError, fn -> Avatars.get_avatar!(avatar.id) end
    end

    test "change_avatar/1 returns a avatar changeset" do
      avatar = avatar_fixture()
      assert %Ecto.Changeset{} = Avatars.change_avatar(avatar)
    end
  end

  describe "avatars_access" do
    alias App.Avatars.AvatarAccess

    import App.AvatarsFixtures

    @invalid_attrs %{is_unlocked: nil}

    test "list_avatars_access/0 returns all avatars_access" do
      avatar_access = avatar_access_fixture()
      assert Avatars.list_avatars_access() == [avatar_access]
    end

    test "get_avatar_access!/1 returns the avatar_access with given id" do
      avatar_access = avatar_access_fixture()
      assert Avatars.get_avatar_access!(avatar_access.id) == avatar_access
    end

    test "create_avatar_access/1 with valid data creates a avatar_access" do
      valid_attrs = %{is_unlocked: true}

      assert {:ok, %AvatarAccess{} = avatar_access} = Avatars.create_avatar_access(valid_attrs)
      assert avatar_access.is_unlocked == true
    end

    test "create_avatar_access/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Avatars.create_avatar_access(@invalid_attrs)
    end

    test "update_avatar_access/2 with valid data updates the avatar_access" do
      avatar_access = avatar_access_fixture()
      update_attrs = %{is_unlocked: false}

      assert {:ok, %AvatarAccess{} = avatar_access} = Avatars.update_avatar_access(avatar_access, update_attrs)
      assert avatar_access.is_unlocked == false
    end

    test "update_avatar_access/2 with invalid data returns error changeset" do
      avatar_access = avatar_access_fixture()
      assert {:error, %Ecto.Changeset{}} = Avatars.update_avatar_access(avatar_access, @invalid_attrs)
      assert avatar_access == Avatars.get_avatar_access!(avatar_access.id)
    end

    test "delete_avatar_access/1 deletes the avatar_access" do
      avatar_access = avatar_access_fixture()
      assert {:ok, %AvatarAccess{}} = Avatars.delete_avatar_access(avatar_access)
      assert_raise Ecto.NoResultsError, fn -> Avatars.get_avatar_access!(avatar_access.id) end
    end

    test "change_avatar_access/1 returns a avatar_access changeset" do
      avatar_access = avatar_access_fixture()
      assert %Ecto.Changeset{} = Avatars.change_avatar_access(avatar_access)
    end
  end
end
