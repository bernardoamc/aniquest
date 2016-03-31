defmodule Aniquest.Users.TokenController do
  use Aniquest.Web, :controller
  alias Aniquest.User

  plug :authenticate_user

  def create(conn, _params) do
    current_user = conn.assigns.current_user
    changeset = User.changeset(current_user, User.generate_token(current_user.email))

    user = Repo.update!(changeset)

    redirect(conn, to: user_path(conn, :show, user))
  end
end
