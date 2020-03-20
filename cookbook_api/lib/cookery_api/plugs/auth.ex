defmodule CookeryWeb.Plugs.Auth do
  import Plug.Conn
  import Ecto.Query

  alias Cookery.Repo
  alias Cookery.Users
  alias Cookery.Users.User
  alias Cookery.SharedCookbooks.SharedCookbook
  alias Cookery.CookbookInvites.CookbookInvite

  def authorize(conn, _) do
    result =
      conn
      |> Guardian.Plug.current_resource()
      |> Users.get_by_id()

    case result do
      %User{} = user -> assign(conn, :user, user)
      _ -> unauth(conn)
    end
  end

  def verify_owner(
        %{params: %{"id" => cookbook_id}, assigns: %{user: %{id: user_id}}} = conn,
        :cookbook
      ),
      do: check_access(conn, :cookbook, cookbook_id, user_id)

  def verify_owner(
        %{params: %{"cookbook_id" => cookbook_id}, assigns: %{user: %{id: user_id}}} = conn,
        :cookbook
      ),
      do: check_access(conn, :cookbook, cookbook_id, user_id)

  def verify_owner(
        %{
          params: %{"cookbook_id" => cookbook_id, "id" => invite_id},
          assigns: %{user: %{id: user_id}}
        } = conn,
        :invitation
      ) do
    query =
      from(i in CookbookInvite)
      |> where(
        [i],
        i.user_id == ^user_id and i.shared_cookbook_id == ^cookbook_id and i.id == ^invite_id
      )

    {cookbook_id, invite_id, user_id} |> IO.inspect()

    case Repo.exists?(query) do
      true -> conn
      false -> conn |> unauth()
    end
  end

  def verify_owner(conn, _), do: conn |> unauth

  # MARK: Private

  defp unauth(conn), do: send_resp(conn, 401, "") |> halt

  defp check_access(conn, :cookbook, cookbook_id, user_id) do
    query =
      from(s in SharedCookbook)
      |> where([s], s.user_id == ^user_id and s.id == ^cookbook_id)

    case Repo.exists?(query) do
      true -> conn
      false -> conn |> unauth()
    end
  end
end
