defmodule CookbookWeb.UserView do
  use CookbookWeb, :view

  alias CookbookWeb.UserView
  alias CookbookWeb.SharedCookbookView

  def render("show.json", %{user: user}),
    do: %{
      id: user.id,
      email: user.email,
      shared_cookbooks: render_many(user.shared_cookbooks, SharedCookbookView, "show.json")
    }

  def render("index.json", %{users: users}),
    do: render_many(users, UserView, "show.json")
end
