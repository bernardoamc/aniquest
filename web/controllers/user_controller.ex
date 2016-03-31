defmodule Aniquest.UserController do
  use Aniquest.Web, :controller
  alias Aniquest.User

  plug :authenticate_user

  def show(conn, _params) do
    current_user = conn.assigns.current_user

    render conn, "show.html", user: current_user
  end
end
