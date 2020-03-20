defmodule Cookery.CookbookInvites do
  import Ecto.Query

  alias Cookery.Repo
  alias Cookery.CookbookInvites.CookbookInvite

  def get_by_id(id), do: Repo.get(CookbookInvite, id)

  def get_by_user_id(user_id) do
    from(i in CookbookInvite)
    |> where([i], i.user_id == ^user_id)
    |> Repo.all()
  end

  def get_by_cookbook_id(cookbook_id) do
    from(i in CookbookInvite)
    |> where([i], i.shared_cookbook_id == ^cookbook_id)
    |> Repo.all()
  end

  def create(params) do
    params
    |> CookbookInvite.insert_changeset()
    |> IO.inspect
    |> Repo.insert()
  end

  def update(%CookbookInvite{} = cookbook, params) do
    cookbook
    |> CookbookInvite.update_changeset(params)
    |> Repo.update()
  end
end
