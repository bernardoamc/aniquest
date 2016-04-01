defmodule Aniquest.Anime do
  use Aniquest.Web, :model

  schema "animes" do
    field :title_romaji, :string
    field :title_english, :string
    field :genres, {:array, :string}
    field :plot, :string

    timestamps
  end

  @required_fields ~w(title_romaji genres plot)
  @optional_fields ~w(title_english)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> normalize_genres
    |> validate_genres
  end

  defp normalize_genres(changeset) do
    if genres = get_change(changeset, :genres) do
      put_change(changeset, :genres, Enum.map(genres, &Aniquest.Genre.normalize_genre(&1)))
    else
      changeset
    end
  end

  defp validate_genres(changeset) do
    if genres = get_change(changeset, :genres) do
      Aniquest.Genre.validate_options(changeset, genres)
    else
      changeset
    end
  end
end
