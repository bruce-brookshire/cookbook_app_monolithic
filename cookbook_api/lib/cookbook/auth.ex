defmodule Cookbook.Auth do
  @moduledoc """
  Auth module used by Guardian.
  """

  use Guardian, otp_app: :cookbook

  def subject_for_token(resource, _claims), do: {:ok, to_string(resource.id)}

  def resource_from_claims(%{"sub" => user_id}), do: {:ok, user_id}
  def resource_from_claims(_claims), do: {:error, :reason_for_error}
end

defmodule Cookbook.AuthErrorHandler do
  @moduledoc false
  # This is automatically used by guardian.

  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    send_resp(conn, 401, "{\"message\": \"" <> to_string(type) <> "\"}")
  end
end
