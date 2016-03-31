defmodule Aniquest.AuthController do
  use Aniquest.Web, :controller
  alias Aniquest.User

  def index(conn, _params) do
    authorize_url = Aniquest.GoogleOauth.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")
    redirect conn, external: authorize_url
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    token = Aniquest.GoogleOauth.get_token!(code: code)
    user_attributes = Aniquest.GoogleOauth.get_user_attributes!(token)
    user = find_or_create_user(user_attributes)

    conn
    |> put_session(:user_id, user.id)
    |> redirect(to: user_path(conn, :show, user))
  end

  defp find_or_create_user(attributes) do
    case Repo.get_by(User, email: attributes[:email]) do
      nil ->
        changeset = User.registration_changeset(%User{}, attributes)
        {:ok, user} = Repo.insert(changeset)
        user

      user ->
        user
    end
  end
end
