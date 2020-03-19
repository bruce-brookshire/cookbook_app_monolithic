defmodule Cookbook.Token do
  @moduledoc """
  Helper for token generation.
  """

  alias Cookbook.Auth
  alias Cookbook.Users.User

  @doc """
  Gets a token for the user `id`. Should not be used unless the user should get a token.

  ## Returns
  `{:ok, token}`
  """
  def token(%User{id: id}) do
    {:ok, token, _} = Auth.encode_and_sign(%{:id => id}, %{typ: "access"}, ttl: {180, :day})
    {:ok, token}
  end
end
