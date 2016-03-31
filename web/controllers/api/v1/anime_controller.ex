defmodule Aniquest.API.V1.AnimeController do
  use Aniquest.Web, :controller

  alias Aniquest.Anime

  plug :scrub_params, "anime" when action in [:create, :update]

  def index(conn, _params) do
    animes = Repo.all(Anime)
    render(conn, "index.json", animes: animes)
  end

  def create(conn, %{"anime" => anime_params}) do
    changeset = Anime.changeset(%Anime{}, anime_params)

    case Repo.insert(changeset) do
      {:ok, anime} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", anime_path(conn, :show, anime))
        |> render("show.json", anime: anime)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Aniquest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    anime = Repo.get!(Anime, id)
    render(conn, "show.json", anime: anime)
  end

  def update(conn, %{"id" => id, "anime" => anime_params}) do
    anime = Repo.get!(Anime, id)
    changeset = Anime.changeset(anime, anime_params)

    case Repo.update(changeset) do
      {:ok, anime} ->
        render(conn, "show.json", anime: anime)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Aniquest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    anime = Repo.get!(Anime, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(anime)

    send_resp(conn, :no_content, "")
  end
end
