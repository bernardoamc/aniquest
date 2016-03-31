defmodule Aniquest.TokenAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Aniquest.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    token = extract_token(conn)

    case repo.get_by(User, token: token) do
      nil ->
        conn
          |> halt_connection_with("Invalid Token")

      user ->
        if Timex.compare(user.token_valid_until, Timex.DateTime.now()) == 1  do
          conn
        else
          conn
            |> halt_connection_with("This token has expired. Please, request a new one.")
        end
    end
  end

  defp extract_token(conn) do
    {"authorization", token_header} =
      List.keyfind(conn.req_headers, "authorization", 0, {"authorization", :token_not_found})

    case token_header do
      :token_not_found ->
        "token_not_found"

      _ ->
        "token " <> token = token_header
        token
    end
  end

  defp halt_connection_with(conn, message) do
    conn
      |> json(%{error: message})
      |> halt()
  end
end
