defmodule Aniquest.AnimeTest do
  use Aniquest.ModelCase

  alias Aniquest.Anime

  @valid_attrs %{genres: ["action", "seinen"], plot: "Hero goes bald", title_english: "Onepunch-Man", title_romaji: "Onepunchman"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Anime.changeset(%Anime{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Anime.changeset(%Anime{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid genres" do
    invalid_params = Map.put(@valid_attrs, :genres, ["invalid_genre", "sports"])

    changeset = Anime.changeset(%Anime{}, invalid_params)
    refute changeset.valid?
  end
end
