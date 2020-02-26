defmodule Cookbook.CookbookParticipants.CookbookParticipant do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cookbook.SharedCookbooks.SharedCookbook
  alias Cookbook.CookbookParticipants.CookbookParticipant

  schema "cookbook_participants" do
    field :user_id, :integer
    field :shared_cookbook_id, :integer

    belongs_to :shared_cookbook, SharedCookbook, define_field: false

    timestamps()
  end

  @req_fields ~w[user_id shared_cookbook_id]a
  @opt_fields []
  @all_fields @req_fields ++ @opt_fields

  def insert_changeset(attrs) do
    %CookbookParticipant{}
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end

  def update_changeset(%CookbookParticipant{} = participant, attrs) do
    participant
    |> cast(attrs, @all_fields)
    |> validate_required(@req_fields)
  end
end
