defmodule CookbookWeb.AuthView do
  use CookbookWeb, :view

  alias CookbookWeb.UserView

  def render("show.json", %{user: user, token: token}),
    do: %{
      user: render_one(user, UserView, "show.json"),
      token: token
    }
end
