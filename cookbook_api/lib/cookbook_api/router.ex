defmodule CookbookWeb.Router do
  use CookbookWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CookbookWeb.Api do
    pipe_through :api

    resources "/users", UserController, only: [:show]
  end
end
