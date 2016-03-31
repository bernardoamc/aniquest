defmodule Aniquest.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Rumbl.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)

    cond do
      user = conn.assigns[:current_user] ->
        assign(conn, :current_user, user)
      user = user_id && repo.get(Aniquest.User, user_id) ->
        assign(conn, :current_user, user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    if Map.get(conn.assigns, :current_user) do
      conn
    else
      conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()
    end
  end
end
