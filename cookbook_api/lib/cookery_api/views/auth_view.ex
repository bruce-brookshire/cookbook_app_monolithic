defmodule CookeryWeb.AuthView do
  use CookeryWeb, :view

  alias CookeryWeb.UserView

  def render("show.json", %{user: user, token: token}),
    do: %{
      user: render_one(user, UserView, "show.json"),
      token: token
    }
end
