defmodule Cookbook.Users do

  import Ecto.Query
  
  alias Cookbook.Users.User
  alias Cookbook.Repo

  def get_by_id(user_id) do
    User
    |> Repo.get(user_id)
    |> Repo.preload([:shared_cookbooks])
  end

  def get_by_email_and_password(email, password) when is_binary(email) and is_binary(password) do
    Repo.get_by(User, email: email, password: password)
    |> Repo.preload([:shared_cookbooks])
  end

  def get_by_email_and_password(_email, _password), do: nil

  def create(params) do
    params 
    |> User.insert_changeset()
    |> Repo.insert
  end

  def update(%User{} = user, params) do
    user 
    |> User.update_changeset(params)
    |> Repo.update
  end
  
end