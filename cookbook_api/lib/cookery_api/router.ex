defmodule CookeryWeb.Router do
  use CookeryWeb, :router

  import CookeryWeb.Plugs.Auth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: Cookery.Auth,
      error_handler: Cookery.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
    plug :authorize
  end

  scope "/api", CookeryWeb.Api do
    pipe_through :api

    post "/users", UserController, :create
    post "/login", AuthController, :login
  end

  scope "/api", CookeryWeb.Api do
    pipe_through :api_auth

    get "/users/cookbook_invitations", Cookbook.InvitationController, :user_cookbook_invites
    get "/users/shared_cookbooks", CookbookController, :cookbooks
    resources "/users", UserController, only: [:show, :update]
    
    resources "/shared_cookbooks", CookbookController, only: [:show, :create, :update] do
      resources "/invitations", Cookbook.InvitationController, only: [:index, :show, :create, :update]
    end
  end
end
