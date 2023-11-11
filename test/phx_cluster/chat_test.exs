defmodule PhxCluster.ChatTest do
  use PhxCluster.DataCase

  alias PhxCluster.Chat

  import PhxCluster.AccountsFixtures

  describe "rooms" do
    alias PhxCluster.Chat.Room

    import PhxCluster.ChatFixtures

    @invalid_attrs %{name: nil}

    setup do
      %{user: user_fixture()}
    end

    test "list_rooms/0 returns all rooms", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      assert Chat.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      assert Chat.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room", %{user: user} do
      valid_attrs = %{name: "some name", user_id: user.id}

      assert {:ok, %Room{} = room} = Chat.create_room(valid_attrs)
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Chat.create_room(@invalid_attrs)
      assert errors_on(changeset) == %{name: ["can't be blank"], user_id: ["can't be blank"]}
    end

    test "update_room/2 with valid data updates the room", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Room{} = room} = Chat.update_room(room, update_attrs)
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = Chat.update_room(room, @invalid_attrs)
      assert room == Chat.get_room!(room.id)
    end

    test "delete_room/1 deletes the room", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      assert {:ok, %Room{}} = Chat.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset", %{user: user} do
      room = room_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Chat.change_room(room)
    end
  end
end
