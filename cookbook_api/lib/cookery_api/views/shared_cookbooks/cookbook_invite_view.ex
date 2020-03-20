defmodule CookeryWeb.SharedCookbooks.CookbookInviteView do
  use CookeryWeb, :view

  alias CookeryWeb.SharedCookbooks.CookbookInviteView

  def render("show.json", %{invite: invite}), do: invite |> Map.take([:id, :is_accepted, :shared_cookbook_id, :user_id])

  def render("index.json", %{invites: invites}),
    do: render_many(invites, CookbookInviteView, "show.json", as: :invite)
end
