defmodule CookeryWeb.Api.Cookbook.InvitationController do
  use CookeryWeb, :controller

  import CookeryWeb.Plugs.Auth

  alias Cookery.CookbookInvites
  alias Cookery.CookbookInvites.CookbookInvite
  alias CookeryWeb.SharedCookbooks.CookbookInviteView

  plug :verify_owner, :cookbook when action in [:create, :index]
  plug :verify_owner, :invitation when action in [:show, :update]

  def show(conn, %{"id" => id}) do
    invite = CookbookInvites.get_by_id(id)

    conn
    |> put_view(CookbookInviteView)
    |> render("show.json", invite: invite)
  end

  def index(conn, %{"cookbook_id" => cookbook_id}) do
    invites = CookbookInvites.get_by_cookbook_id(cookbook_id)

    conn
    |> put_view(CookbookInviteView)
    |> render("index.json", invites: invites)
  end
  
  def user_cookbook_invites(%{assigns: %{user: %{id: user_id}}} = conn, params) do
    invites = CookbookInvites.get_by_user_id(user_id)

    conn
    |> put_view(CookbookInviteView)
    |> render("index.json", invites: invites)
  end

  def create(conn, %{"cookbook_id" => cookbook_id} = params) do
    # Cookery id rename from convenience name
    params = Map.put(params, "shared_cookbook_id", cookbook_id)

    case CookbookInvites.create(params) do
      {:ok, invite} ->
        conn
        |> put_view(CookbookInviteView)
        |> render("show.json", invite: invite)

      _ ->
        conn
        |> send_resp(422, "Invalid parameters")
    end
  end

  def update(conn, %{"id" => id} = params) do
    invite = CookbookInvites.get_by_id(id)

    case CookbookInvites.update(invite, params) do
      {:ok, invite} ->
        conn
        |> put_view(CookbookInviteView)
        |> render("show.json", invite: invite)

      _ ->
        conn
        |> send_resp(422, "Invalid parameters")
    end
  end
end
