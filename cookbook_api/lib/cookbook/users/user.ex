defmodule Cookbook.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cookbook.Users.User
  alias Cookbook.SharedCookbooks.SharedCookbook


  schema "users" do
    field :email, :string
    field :name_first, :string
    field :name_last, :string
    field :password, :string

    has_many :shared_cookbooks, SharedCookbook

    timestamps()
  end

  @req_fields ~w[email name_last name_first password]
  @opt_fields []
  @all_fields @req_fields ++ @opt_fields

  def insert_changeset(attrs) do
    %User{}
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
  
  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end