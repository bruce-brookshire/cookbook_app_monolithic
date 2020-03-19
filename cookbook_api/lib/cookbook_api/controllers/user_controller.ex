defmodule CookbookWeb.Api.UserController do
  use CookbookWeb, :controller

  alias Cookbook.Users
  alias Cookbook.Users.User
  alias CookbookWeb.UserView

  def show(conn, %{"id" => id}) do
    user = Users.get_by_id(id)
    
    conn
    |> put_view(UserView)
    |> render("show.json", user: user)
  end

  def create(conn, params) do
    case Users.create(params) do
      {:ok, %User{} = user} -> 
        conn
        |> put_view(UserView)
        |> render("show.json", user: user)
      _ -> 
        conn
        |> send_resp(422, "Invalid parameters")
    end
  end

  def update(%{assigns: %{user: %User{} = user}} = conn, params) do
    case Users.update(user, params) do
      {:ok, %User{} = user} -> 
        conn
        |> put_view(UserView)
        |> render("show.json", user: user)
      _ -> 
        conn
        |> send_resp(422, "Invalid parameters")
    end
  end
end
