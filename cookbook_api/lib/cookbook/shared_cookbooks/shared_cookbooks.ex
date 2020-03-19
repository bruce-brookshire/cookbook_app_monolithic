defmodule Cookbook.SharedCookbooks do
  alias Cookbook.SharedCookbooks.SharedCookbook

  alias Cookbook.Repo

  def get_by_id(id), do: 
    Repo.get(SharedCookbook, id)
end