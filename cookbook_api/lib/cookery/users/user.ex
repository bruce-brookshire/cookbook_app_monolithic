defmodule Cookery.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cookery.Users.User
  alias Cookery.SharedCookbooks.SharedCookbook
  alias Cookery.CookbookInvites.CookbookInvite


  schema "users" do
    field :email, :string
    field :name_first, :string
    field :name_last, :string
    field :password, :string

    has_many :cookbooks, SharedCookbook
    many_to_many :shared_cookbooks, SharedCookbook, join_through: CookbookInvite

    timestamps()
  end

  @req_fields ~w[email name_last name_first password]a
  @opt_fields []
  @all_fields @req_fields ++ @opt_fields

  def insert_changeset(attrs) do
    %User{}
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
    |> unique_constraint(:email)
  end
  
  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end