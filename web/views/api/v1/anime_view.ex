defmodule Aniquest.API.V1.AnimeView do
  use Aniquest.Web, :view

  def render("index.json", %{animes: animes}) do
    %{data: render_many(animes, Aniquest.API.V1.AnimeView, "anime.json")}
  end

  def render("show.json", %{anime: anime}) do
    %{data: render_one(anime, Aniquest.API.V1.AnimeView, "anime.json")}
  end

  def render("anime.json", %{anime: anime}) do
    %{id: anime.id,
      title_romaji: anime.title_romaji,
      title_english: anime.title_english,
      genres: anime.genres,
      plot: anime.plot}
  end
end
