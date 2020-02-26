defmodule Cookbook.CookbookInvites.CookbookInvite do
  
  use Ecto.Schema

  import Ecto.Changeset
  
  alias Cookbook.SharedCookbooks.SharedCookbook
  alias Cookbook.CookbookInvites.CookbookInvite

  schema "cookbook_invite" do
    field :user_id, :integer
    field :shared_cookbook_id, :integer
    field :is_accepted, :boolean

    belongs_to :shared_cookbook, SharedCookbook, define_field: false

    timestamps()
  end

  @req_fields ~w[user_id shared_cookbook_id]a
  @opt_fields ~w[is_accepted]
  @all_fields @req_fields ++ @opt_fields

  def insert_changeset(attrs) do
    %CookbookInvite{}
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end

  def update_changeset(%CookbookInvite{} = invite, attrs) do
    invite
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end