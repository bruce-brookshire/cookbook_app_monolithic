defmodule CookbookWeb.Router do
  use CookbookWeb, :router

  import CookbookWeb.Plugs.Auth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: Cookbook.Auth,
      error_handler: Cookbook.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
    plug :authorize
  end

  scope "/api", CookbookWeb.Api do
    pipe_through :api

    post "/users", UserController, :create

    post "/login", AuthController, :login
  end

  scope "/api", CookbookWeb.Api do
    pipe_through :api_auth

    resources "/users", UserController, only: [:show, :update]
  end
end
