defmodule CookbookWeb.Plugs.Auth do
  import Plug.Conn

  alias Cookbook.Users
  alias Cookbook.Users.User

  def authorize(conn, _) do
    IO.puts("Hello")

    result =
      conn
      |> Guardian.Plug.current_resource()
      |> Users.get_by_id()

    case result do
      %User{} = user -> assign(conn, :user, user)
      _ -> unauth(conn)
    end
  end

  defp unauth(conn), do: send_resp(conn, 401, "") |> halt
end
