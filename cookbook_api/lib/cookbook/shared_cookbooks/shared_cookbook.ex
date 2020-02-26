defmodule Cookbook.SharedCookbooks.SharedCookbook do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cookbook.Users.User
  alias Cookbook.SharedCookbooks.SharedCookbook

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

  def update_changeset(%SharedCookbook{} = cookbook, attrs) do
    cookbook
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end
