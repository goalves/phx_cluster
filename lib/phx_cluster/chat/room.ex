defmodule PhxCluster.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxCluster.Accounts.User

  @attrs [:name, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rooms" do
    field :name, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%__MODULE__{} = room, attrs) do
    room
    |> cast(attrs, @attrs)
    |> validate_required(@attrs)
    |> unique_constraint(:name)
  end
end
