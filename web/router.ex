defmodule Aniquest.Router do
  use Aniquest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Aniquest.UserAuth, repo: Aniquest.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Aniquest.TokenAuth, repo: Aniquest.Repo
  end

  scope "/", Aniquest do
    pipe_through :browser

    get "/", PageController, :index

    get "/auth", AuthController, :index
    get "/auth/callback", AuthController, :callback
    delete "/auth/logout", AuthController, :delete

    resources "/users", UserController, only: [:show]
    post "/users/token/create", Users.TokenController, :create
  end

  scope "/api", Aniquest do
    pipe_through :api

    resources "/v1/animes", API.V1.AnimeController, except: [:new, :edit]
  end
end
