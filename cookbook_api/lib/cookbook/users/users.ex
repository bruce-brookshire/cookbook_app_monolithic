defmodule Cookbook.Users do

  import Ecto.Query
  
  alias Cookbook.Users.User
  alias Cookbook.Repo

  def get_by_id(user_id) do
    User
    |> Repo.get(user_id)
    |> Repo.preload([:shared_cookbooks])
  end
  
end