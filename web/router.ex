defmodule Aniquest.Router do
  use Aniquest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Aniquest do
    pipe_through :browser

    get "/", PageController, :index

    get "/auth", AuthController, :index
    get "/auth/callback", AuthController, :callback
    delete "/auth/logout", AuthController, :delete
  end

  scope "/api", Aniquest do
    pipe_through :api

    resources "/v1/animes", API.V1.AnimeController, except: [:new, :edit]
  end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
