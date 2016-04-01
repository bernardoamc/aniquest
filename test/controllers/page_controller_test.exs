defmodule Aniquest.PageControllerTest do
  use Aniquest.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Example APP using OAuth2 and Token Based Authorization for APIs"
  end
end
