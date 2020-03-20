defmodule Cookery.Repo do
  use Ecto.Repo,
    otp_app: :cookery,
    adapter: Ecto.Adapters.Postgres
end
