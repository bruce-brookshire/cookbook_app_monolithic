defmodule CookbookWeb.Api.UserController do
  use CookbookWeb, :controller

  alias Cookbook.Users
  alias CookbookWeb.UserView

  def show(conn, %{"id" => id}) do
    user = Users.get_by_id(id)
    
    conn
    |> put_view(UserView)
    |> render("show.json", user: user)
  end
end
