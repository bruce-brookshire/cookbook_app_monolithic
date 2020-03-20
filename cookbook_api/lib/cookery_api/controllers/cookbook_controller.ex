defmodule CookeryWeb.Api.CookbookController do
  use CookeryWeb, :controller

  import CookeryWeb.Plugs.Auth

  alias Cookery.SharedCookbooks
  alias Cookery.SharedCookbooks.SharedCookbook
  alias CookeryWeb.SharedCookbookView

  plug :verify_owner, :cookbook when action in [:show, :update]

  def show(conn, %{"id" => id}) do
    case SharedCookbooks.get_by_id(id) do
      %SharedCookbook{} = cookbook ->
        conn
        |> put_view(SharedCookbookView)
        |> render("show.json", shared_cookbook: cookbook)

      _ ->
        conn |> send_resp(404, "Not found")
    end
  end

  def cookbooks(%{assigns: %{user: %{id: user_id}}} = conn, params) do
    cookbooks = SharedCookbooks.get_user_cookbooks(user_id)

    conn
    |> put_view(SharedCookbookView)
    |> render("index.json", shared_cookbooks: cookbooks)
  end

  def create(%{assigns: %{user: %{id: user_id}}} = conn, params) do
    result =
      params
      |> Map.put("user_id", user_id)
      |> SharedCookbooks.create()

    case result do
      {:ok, cookbook} ->
        conn
        |> put_view(SharedCookbookView)
        |> render("show.json", shared_cookbook: cookbook)

      _ ->
        conn
        |> send_resp(422, "Invalid Parameters")
    end
  end

  def update(conn, %{"id" => id} = params) do
    with %SharedCookbook{} = old_cookbook <- SharedCookbooks.get_by_id(id),
         {:ok, new_cookbook} <- SharedCookbooks.update(old_cookbook, params) do
      conn
      |> put_view(SharedCookbookView)
      |> render("show.json", shared_cookbook: new_cookbook)
    else
      nil -> send_resp(conn, 404, "Not found")
      _ -> send_resp(conn, 422, "Invalid Parameters")
    end
  end
end
