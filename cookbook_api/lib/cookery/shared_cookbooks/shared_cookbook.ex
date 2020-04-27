defmodule Cookery.SharedCookbooks.SharedCookbook do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cookery.Users.User
  alias Cookery.SharedCookbooks.SharedCookbook

  schema "shared_cookbooks" do
    field :user_id, :integer
    field :name, :string

    timestamps()

    belongs_to :user, User, define_field: false
  end

  @req_fields ~w[user_id name]a
  @opt_fields []
  @all_fields @req_fields ++ @opt_fields

  def insert_changeset(attrs) do
    %SharedCookbook{}
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end

  def changeset(%SharedCookbook{} = cookbook, attrs) do
    cookbook
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end
