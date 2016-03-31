defmodule Aniquest.AuthController do
  use Aniquest.Web, :controller

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
    # Exchange an auth code for an access token
    token = Aniquest.GoogleOauth.get_token!(code: code)

    # Request the user's data with the access token
    user = Aniquest.GoogleOauth.get_user!(token)

    IO.puts "USERRRRRRR"
    IO.inspect user
    IO.puts "USERRRRRRR"

    conn
    |> put_session(:current_user, user)
    |> redirect(to: "/")
  end
end
