defmodule Aniquest.PageController do
  use Aniquest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
