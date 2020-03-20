defmodule CookeryWeb.Api.UserController do
  use CookeryWeb, :controller

  alias Cookery.Repo
  alias Cookery.Users
  alias Cookery.Users.User
  alias CookeryWeb.UserView

  def show(conn, %{"id" => id}) do
    user = Users.get_by_id(id)
    render_user(conn, user)
  end

  def create(conn, params) do
    case Users.create(params) do
      {:ok, %User{} = user} -> conn |> render_user(user)
      _ -> send_resp(conn, 422, "Invalid parameters")
    end
  end

  def update(%{assigns: %{user: %User{} = user}} = conn, params) do
    case Users.update(user, params) do
      {:ok, %User{} = user} -> conn |> render_user(user)
      _ -> send_resp(conn, 422, "Invalid parameters")
    end
  end

  defp render_user(conn, user) do
      conn
      |> put_view(UserView)
      |> render("show.json", user: Repo.preload(user, [:shared_cookbooks, :cookbooks]))
  end
end
