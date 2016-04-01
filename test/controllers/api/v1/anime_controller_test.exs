defmodule Aniquest.API.V1.AnimeControllerTest do
  use Aniquest.ConnCase

  alias Aniquest.Anime
  alias Aniquest.User

  @valid_attrs %{genres: ["action", "seinen"], plot: "Hero goes bald", title_english: "Onepunch-Man", title_romaji: "Onepunchman"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    changeset = User.registration_changeset(
      %User{}, %{name: "Tester", email: "test@gmail.com", picture: "test.png"})

    user = Repo.insert!(changeset)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "token #{user.token}")

    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, anime_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    anime = Repo.insert! %Anime{}
    conn = get conn, anime_path(conn, :show, anime)
    assert json_response(conn, 200)["data"] == %{"id" => anime.id,
      "title_romaji" => anime.title_romaji,
      "title_english" => anime.title_english,
      "genres" => anime.genres,
      "plot" => anime.plot}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, anime_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, anime_path(conn, :create), anime: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Anime, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, anime_path(conn, :create), anime: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    anime = Repo.insert! %Anime{}
    conn = put conn, anime_path(conn, :update, anime), anime: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Anime, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    anime = Repo.insert! %Anime{}
    conn = put conn, anime_path(conn, :update, anime), anime: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    anime = Repo.insert! %Anime{}
    conn = delete conn, anime_path(conn, :delete, anime)
    assert response(conn, 204)
    refute Repo.get(Anime, anime.id)
  end
end
