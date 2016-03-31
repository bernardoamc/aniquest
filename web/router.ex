defmodule Aniquest.Router do
  use Aniquest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Aniquest do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Aniquest do
    pipe_through :api

    resources "/v1/animes", API.V1.AnimeController, except: [:new, :edit]
  end
end
