defmodule CookeryWeb.Api.AuthController do
  use CookeryWeb, :controller

  alias Cookery.Token
  alias Cookery.Auth
  alias Cookery.Users
  alias Cookery.Users.User
  alias CookeryWeb.AuthView

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
