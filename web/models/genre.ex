defmodule Aniquest.Genre do
  import Ecto.Changeset

  @valid_options ~w(
    action adult adventure comedy comic cooking doujinshi drama ecchi
    fantasy gender_bender harem historical horror josei lolicon manga
    manhua manhwa martial_arts mature mecha medical music mystery
    one_shot psychological romance school_life sci_fi seinen shotacon
    shoujo shoujo_ai shounen shounen_ai slice_of_life smut sports
    supernatural tragedy webtoon yaoi yuri
  )

  def validate_options(changeset, genres) do
    if valid_options?(genres) do
      changeset
    else
      add_error(changeset, :genres, "has invalid genres.")
    end
  end

  def valid_options?(genres) do
    Enum.all?(genres, fn(genre) ->
      Enum.member?(@valid_options, genre)
    end)
  end

  def normalize_genre(genre) do
    genre
      |> String.strip
      |> String.downcase
      |> String.replace(" ", "_")
  end
end
