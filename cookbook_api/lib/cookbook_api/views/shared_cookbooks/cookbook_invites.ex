defmodule CookbookWeb.SharedCookbooks.CookbookInviteView do
  use CookbookWeb, :view

  alias CookbookWeb.SharedCookbooks.CookbookInviteView

  def render("show.json", %{invite: invite}), do: invite |> Map.take([:id, :is_accepted])

  def render("index.json", %{invites: invites}),
    do: render_many(invites, CookbookInviteView, "show.json", as: :invite)
end
