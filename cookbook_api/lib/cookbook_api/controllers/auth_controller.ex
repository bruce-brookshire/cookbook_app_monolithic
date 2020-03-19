defmodule CookbookWeb.Api.AuthController do
  use CookbookWeb, :controller

  alias Cookbook.Token
  alias Cookbook.Auth
  alias Cookbook.Users
  alias Cookbook.Users.User
  alias CookbookWeb.AuthView

  def login(conn, %{"email" => email, "password" => password}) do
    with %User{} = user <- Users.get_by_email_and_password(email, password),
         {:ok, token} <- Token.token(user) do
      conn
      |> put_view(AuthView)
      |> render("show.json", user: user, token: token)
    else
      _ ->
        send_resp(conn, 401, "Not Authorized")
    end
  end
end
