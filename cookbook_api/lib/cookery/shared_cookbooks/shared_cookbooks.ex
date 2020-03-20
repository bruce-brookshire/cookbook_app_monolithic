defmodule Cookery.SharedCookbooks do

  import Ecto.Query

  alias Cookery.Repo
  alias Cookery.CookbookInvites.CookbookInvite
  alias Cookery.SharedCookbooks.SharedCookbook

  def get_by_id(id), do: Repo.get(SharedCookbook, id)

  def get_user_cookbooks(user_id) do
    owned_cookbooks = from(s in SharedCookbook)
    |> where([s], s.user_id == ^user_id)
    |> Repo.all() || []

    shared_cookbooks = from(s in SharedCookbook)
    |> join(:inner, [s], i in CookbookInvite, on: s.id == i.shared_cookbook_id)
    |> where([s, i], i.user_id == ^user_id)
    |> Repo.all() || []

    owned_cookbooks ++ shared_cookbooks
  end

  def create(params) do
    params
    |> SharedCookbook.insert_changeset
    |> Repo.insert
  end
  
  def update(%SharedCookbook{} = cookbook, params) do
    cookbook
    |> SharedCookbook.update_changeset(params)
    |> Repo.update
  end
end
