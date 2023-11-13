defmodule PhxCluster.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhxCluster.Accounts.User

  @attrs [:content, :user_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  embedded_schema do
    field :content, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%__MODULE__{} = message, attrs) do
    message
    |> cast(attrs, @attrs)
    |> validate_required(@attrs)
  end
end
